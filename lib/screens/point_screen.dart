import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

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
  String _consistency = '';
  String _shot = '';
  String _direction = '';
  String _depth = '';

  _storeRallyEvent() {
    Map rallyEvent = newRallyEvent(
        createdAt: DateTime.now(),
        match: widget.match,
        player: _player,
        consistency: _consistency,
        shot: _shot,
        direction: _direction,
        depth: _depth);
    Map scoreEvent = newScoreFromRally(
        DateTime.now(), widget.match, widget.match['events'].last, rallyEvent);

    widget.match['events'].add(rallyEvent);
    widget.match['events'].add(scoreEvent);
    widget.storage.create(widget.match);
  }

  void handleClick(String value) async {
    switch (value) {
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

  bool isServiceStroke() {
    return ['A', 'F', 'DF'].contains(_shot);
  }

  List<Widget> _whoTouchedTheBallLast() {
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
                label: Text(widget.match['p1']),
                selected: _player == 'p1',
                onSelected: (bool selected) {
                  setState(() {
                    _player = 'p1';
                    _save();
                  });
                }),
            ChoiceChip(
                label: Text(widget.match['p2']),
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
    final options = whatWasTheShotHitOptions(
        consistency: _consistency,
        isServing: isServing(),
        isServiceFault: score()['isServiceFault']);
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: <Widget>[
            for (var item in options['options'])
              ChoiceChip(
                label: Text(item['label']),
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
    final options =
        whereDidTheBallLandOptions(direction: _direction, shot: _shot);
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: <Widget>[
            for (var item in options['options'])
              ChoiceChip(
                label: Text(item['label']),
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
    if (_player != '' && _shot != '' && _depth != '') {
      _storeRallyEvent();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PointScreen(widget.match)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(formatScore(widget.match, widget.match['events'].last)),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Finish'}.map((String choice) {
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
        child: ListView(
            children: _whoTouchedTheBallLast() +
                [Divider()] +
                _whatWasTheShotHit() +
                [Divider()] +
                _whereDidTheBallLand()),
      ),
    );
  }
}
