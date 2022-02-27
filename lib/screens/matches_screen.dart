import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import '../matches_storage.dart';
import 'new_match_screen.dart';
import '../models/match.dart';
import '../logic/date_time.dart';
import '../logic/match.dart';
import 'match_screen.dart';

class MatchesScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List _matches = [];
  late String _title;

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

  void _setupScreen() {
    Wakelock.disable();

    SystemChrome.setPreferredOrientations(isLandscape
        ? [
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]
        : [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  void _refresh() {
    setState(() => _title = "Loading matches...");
    widget.storage.loadAll().then((matches) {
      setState(() {
        _matches = matches;
        _title = "Matches (${matches.length})";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void handleClick(String value) async {
    if (value == portraitScreenOrientation) {
      isLandscape = false;
      _setupScreen();
    } else if (value == landscapeScreenOrientation) {
      isLandscape = true;
      _setupScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupScreen();

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
      body: ListView.builder(
        itemCount: _matches.length,
        itemBuilder: (context, index) {
          final match = _matches[index];
          final isFinished = match['events'].last['event'] == 'FinalScore';
          final status = isFinished ? 'finished' : 'in progress';

          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MatchScreen(match);
                })).then((val) => _refresh());
              },
              title: Text(
                  '${match['p1']} vs ${match['p2']} - ${formatDateTime(match['createdAt'], DateTime.now())}'),
              subtitle:
                  Text('${match['surface']} - ${match['venue']} - $status'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Add match',
        child: Icon(Icons.add),
      ),
    );
  }
}
