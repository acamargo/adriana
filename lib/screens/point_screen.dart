import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:vibration/vibration.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

import '../matches_storage.dart';
import 'stats_screen.dart';
import '../logic/score.dart';
import '../logic/rally.dart';

class PointScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();
  final Map match;

  PointScreen(this.match);

  @override
  _PointScreenState createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  String _player = '';
  String _shot = '';
  String _depth = '';

  _storeRallyEvent() {
    Map rallyEvent = newRallyEvent(
        createdAt: DateTime.now(),
        match: widget.match,
        player: _player,
        shot: _shot,
        depth: _depth);
    Map scoreEvent = newScoreFromRally(
        DateTime.now(), widget.match, widget.match['events'].last, rallyEvent);

    widget.match['events'].add(rallyEvent);
    widget.match['events'].add(scoreEvent);
    widget.storage.create(widget.match);
  }

  Widget choiceChip(
      {required String label, required bool selected, required onSelected}) {
    return ChoiceChip(
        padding: EdgeInsets.all(10),
        label: Text(label,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        selected: selected,
        backgroundColor: Colors.white,
        selectedColor: Colors.lightGreenAccent,
        onSelected: onSelected);
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Report':
        var excel =
            Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
        var fileBytes = excel.save();
        var directory = await getApplicationDocumentsDirectory();
        final filePath = "${directory.path}/output_file_name.xlsx";

        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes as List<int>);

        final _result = await OpenFile.open(filePath);
        print(_result.message);
        break;
      case 'Finish':
        bool result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${widget.match['p1']} vs ${widget.match['p2']}"),
              content: Text("Would you like to finish the match?"),
              actions: [
                TextButton(
                  child: Text("YES"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                  },
                ),
                TextButton(
                  child: Text("NO"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                ),
              ],
            );
          },
        );
        if (result) {
          Map lastScore = widget.match['events'].last;
          Map finalScoreEvent = {
            'event': 'FinalScore',
            'createdAt': DateTime.now(),
            'pointNumber': lastScore['pointNumber'],
            'p1': lastScore['p1'],
            'p2': lastScore['p2'],
            'state': 'Match finished'
          };
          widget.match['events'].add(finalScoreEvent);
          widget.storage.create(widget.match);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StatsScreen(widget.match),
            ),
          );
        }
        break;
    }
  }

  bool _undoAllowed() {
    final events = widget.match['events'];
    final length = events.length;
    return events[length - 2]['event'] == 'Rally' &&
        events[length - 1]['event'] == 'Score';
  }

  void handleUndo() async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${widget.match['p1']} vs ${widget.match['p2']}"),
          content: Text("Would you like to undo the last shot?"),
          actions: [
            TextButton(
              child: Text("YES"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
            ),
            TextButton(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(false);
              },
            ),
          ],
        );
      },
    );
    if (result) {
      widget.match['events'].removeLast();
      widget.match['events'].removeLast();
      print(widget.match['events']);
      widget.storage.create(widget.match);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PointScreen(widget.match)));
    }
  }

  Map score() {
    return widget.match['events'].last;
  }

  String whoIsServing() {
    return score()['server'];
  }

  String whoIsReceiving() {
    return whoIsServing() == 'p1' ? 'p2' : 'p1';
  }

  bool isServing() {
    return _player == whoIsServing();
  }

  List<Widget> _whoTouchedTheBallLast() {
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: [
            choiceChip(
                label: widget.match['p1'],
                selected: _player == 'p1',
                onSelected: (bool selected) {
                  setState(() {
                    _player = 'p1';
                    _save();
                  });
                }),
            choiceChip(
                label: widget.match['p2'],
                selected: _player == 'p2',
                onSelected: (bool selected) {
                  setState(() {
                    _player = 'p2';
                    _save();
                  });
                }),
          ],
        ),
      ),
    ];
  }

  List<Widget> _whatWasTheShotHit() {
    final options = whatWasTheShotHitOptions(isServing: isServing());
    if (!options['options']
        .map((item) => item['value'])
        .toList()
        .contains(_shot)) _shot = '';
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: <Widget>[
            for (var item in options['options'])
              choiceChip(
                label: item['label'],
                selected: _shot == item['value'],
                onSelected: (bool selected) => setState(() {
                  _shot = item['value'];
                  _save();
                }),
              )
          ],
        ),
      ),
    ];
  }

  List<Widget> _whereDidTheBallLand() {
    final options = whereDidTheBallLandOptions(shot: _shot);
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: <Widget>[
            for (var item in options['options'])
              choiceChip(
                label: item['label'],
                selected: _depth == item['value'],
                onSelected: (bool selected) => setState(() {
                  _depth = item['value'];
                  _save();
                }),
              )
          ],
        ),
      ),
    ];
  }

  _save() {
    Vibration.vibrate();
    if (_player != '' && _shot != '' && _depth != '') {
      FlutterBeep.beep(false);
      _storeRallyEvent();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PointScreen(widget.match)));
    } else {
      FlutterBeep.beep();
    }
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    if (_player == '') {
      _player = whoIsServing();
      if (_shot == '') _shot = 'SV';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(formatScore(widget.match, widget.match['events'].last),
            style: TextStyle(color: Colors.lightGreenAccent)),
        actions: <Widget>[
          if (_undoAllowed())
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: handleUndo,
                  child: Icon(
                    Icons.undo,
                    size: 26.0,
                  ),
                )),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Report', 'Finish'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _whoTouchedTheBallLast() +
                [Divider()] +
                _whatWasTheShotHit() +
                [Divider()] +
                _whereDidTheBallLand()),
      ),
    );
  }
}
