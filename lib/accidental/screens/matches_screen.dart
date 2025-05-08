import 'package:adriana/accidental/storage/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:adriana/accidental/storage/matches.dart';
import 'new_match_screen.dart';
import 'package:adriana/accidental/models/match.dart';
import 'package:adriana/accidental/logic/date_time.dart';
import 'package:adriana/essential/match.dart';
import 'match_screen.dart';

class MatchesScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();
  final PreferencesStorage preferences = PreferencesStorage();

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List _matches = [];
  List _listMatchFiles = [];
  String _title = "Matches";
  bool _isLoadingMatchesList = false;

  bool isLandscape = true;
  final String portraitScreenOrientation = "Set portrait mode";
  final String landscapeScreenOrientation = "Set landscape mode";

  void _add() async {
    Match? results = await Navigator.of(context).push(MaterialPageRoute<Match>(
        builder: (BuildContext context) => NewMatchScreen({}),
        fullscreenDialog: true));
    if (results != null) {
      final match = newMatch(
          createdAt: DateTime.now(),
          p1: results.p1,
          p2: results.p2,
          surface: results.surface,
          venue: results.venue);
      widget.storage.create(match);
      setState(() => _matches.insert(0, match));
    }
  }

  Future<void> _setupScreen() async {
    Wakelock.disable();

    isLandscape = await widget.preferences.isLandscape();

    SystemChrome.setPreferredOrientations(isLandscape
        ? [
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]
        : [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  void _refresh() {
    widget.storage.loadListMatches().then((listMatches) {
      _listMatchFiles = listMatches;
      setState(() {
        _isLoadingMatchesList = true;
        _title = "Matches";
        _matches = [];
      });
      Future.wait(listMatches
          .map((file) => widget.storage.loadMatch(file))
          .toList())
          .then((matches) {
        setState(() {
          _matches.addAll(matches);
          if (_listMatchFiles.length > 0)
            _title = "Matches (${_listMatchFiles.length})";
          _isLoadingMatchesList = false;
        });
      });
    });
  }

  void requestStoragePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    print(statuses[Permission.storage]);

    var state = await Permission.manageExternalStorage.status;
    var state2 = await Permission.storage.status;
    if (!state2.isGranted) {
      await Permission.storage.request();
    }
    if (!state.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    _setupScreen();
    _refresh();
    requestStoragePermissions();
    widget.storage.copyFilesToSdCard();
  }

  void handleClick(String value) async {
    if (value == portraitScreenOrientation) {
      await widget.preferences.setLandscape(false);
      _setupScreen();
    } else if (value == landscapeScreenOrientation) {
      await widget.preferences.setLandscape(true);
      _setupScreen();
    } else if (value == 'Refresh') {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                isLandscape
                    ? portraitScreenOrientation
                    : landscapeScreenOrientation,
                'Refresh'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _isLoadingMatchesList
          ? Center(child: Text('Loading matches...'))
          : _matches.isEmpty
              ? Center(child: Text('Tap "+" to add a match.'))
              : ListView.builder(
                  itemCount: _matches.length,
                  itemBuilder: (context, index) {
                    final match = _matches[index];
                    final isFinished =
                        match['events'].last['event'] == 'FinalScore';
                    final status = isFinished ? 'finished' : 'in progress';

                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return MatchScreen(match);
                          })).then((_) {
                            // Update match entry when necessary
                            var matchFile = _listMatchFiles[index];
                            if (widget.storage.exist(matchFile)) {
                              widget.storage.loadMatch(matchFile).then((value) {
                                setState(() => _matches[index] = value);
                              });
                            } else {
                              setState(() {
                                _listMatchFiles.removeAt(index);
                                _matches.removeAt(index);
                              });
                            }
                          });
                        },
                        title: Text(
                            '${match['p1']} vs ${match['p2']} - ${formatDateTime(match['createdAt'], DateTime.now())}'),
                        subtitle: Text(
                            '${match['surface']} - ${match['venue']} - $status'),
                      ),
                    );
                  },
                ),
      floatingActionButton: Visibility(
        visible: !_isLoadingMatchesList,
        child: FloatingActionButton(
          onPressed: _add,
          tooltip: 'Add match',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
