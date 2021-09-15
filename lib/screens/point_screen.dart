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
      if (_player == '') Text("Who touched the ball last?"),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
                label: Text(widget.match['p1']),
                selected: _player == 'p1',
                onSelected: (bool selected) {
                  setState(() => _player = 'p1');
                }),
            ChoiceChip(
                label: Text(widget.match['p2']),
                selected: _player == 'p2',
                onSelected: (bool selected) {
                  setState(() => _player = 'p2');
                }),
          ],
        ),
      ),
      Divider(),
    ];
  }

  List<Widget> _whatWasTheRallyLength() {
    final options = whatWasTheRallyLengthOptions(
        player: _player, consistency: _consistency, isServing: isServing());
    if (!options['options']
        .map((item) => item['value'])
        .toList()
        .contains(_consistency)) _consistency = '';
    if (options['options'].isEmpty) {
      return [];
    } else {
      return [
        if (_consistency == '') Text(options['label']),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10,
            children: <Widget>[
              for (var item in options['options'])
                ChoiceChip(
                  label: Text(item['label']),
                  selected: _consistency == item['value'],
                  onSelected: (bool selected) =>
                      setState(() => _consistency = item['value']),
                )
            ],
          ),
        ),
        Divider(),
      ];
    }
  }

  List<Widget> _whatWasTheShotHit() {
    final options = whatWasTheShotHitOptions(
        consistency: _consistency,
        isServing: isServing(),
        isServiceFault: score()['isServiceFault']);
    if (!options['options']
        .map((item) => item['value'])
        .toList()
        .contains(_shot)) _shot = '';
    if (options['options'].isEmpty) {
      return [];
    } else {
      return [
        if (_shot == '') Text(options['label']),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10,
            children: <Widget>[
              for (var item in options['options'])
                ChoiceChip(
                  label: Text(item['label']),
                  selected: _shot == item['value'],
                  onSelected: (bool selected) =>
                      setState(() => _shot = item['value']),
                )
            ],
          ),
        ),
        Divider(),
      ];
    }
  }

  List<Widget> _whatWastheBallDirection() {
    final options = whatWasTheBallDirectionOptions(
        shot: _shot,
        isServiceStroke: isServiceStroke(),
        whoIsReceiving: whoIsReceiving());
    if (!options['options']
        .map((item) => item['value'])
        .toList()
        .contains(_direction)) _direction = '';
    if (options['options'].isEmpty) {
      return [];
    } else {
      return [
        if (_direction == '') Text(options['label']),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10,
            children: <Widget>[
              for (var item in options['options'])
                ChoiceChip(
                  label: Text(item['label']),
                  selected: _direction == item['value'],
                  onSelected: (bool selected) =>
                      setState(() => _direction = item['value']),
                )
            ],
          ),
        ),
        Divider(),
      ];
    }
  }

  List<Widget> _whereDidTheBallLand() {
    if (_direction == '')
      return [];
    else
      return [
        if (_depth == '') Text("Where did the ball land?"),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10,
            children: [
              if (_shot != "A")
                ChoiceChip(
                  label: Text("into the net"),
                  selected: _depth == "N",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "N";
                    });
                  },
                ),
              if (_shot != "F" && _shot != "DF")
                ChoiceChip(
                  label: Text("short"),
                  selected: _depth == "S",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "S";
                    });
                  },
                ),
              if (_shot != "F" && _shot != "DF")
                ChoiceChip(
                  label: Text("deep"),
                  selected: _depth == "D",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "D";
                    });
                  },
                ),
              if (_shot != "A")
                ChoiceChip(
                  label: Text("long"),
                  selected: _depth == "L",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "L";
                    });
                  },
                ),
              if (_shot != "A")
                ChoiceChip(
                  label: Text("wide"),
                  selected: _depth == "W",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "W";
                    });
                  },
                ),
            ],
          ),
        ),
        Divider(),
      ];
  }

  List<Widget> _saveButton() {
    if (_player != '' &&
        _consistency != '' &&
        _shot != '' &&
        _direction != '' &&
        _depth != '')
      return [
        ElevatedButton(
          onPressed: () {
            _storeRallyEvent();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PointScreen(widget.match)));
          },
          child: Text('Save'),
        ),
      ];
    else
      return [];
  }

  @override
  Widget build(BuildContext context) {
    // Wakelock.enable();

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

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
              _whatWasTheRallyLength() +
              _whatWasTheShotHit() +
              _whatWastheBallDirection() +
              _whereDidTheBallLand() +
              _saveButton(),
        ),
      ),
    );
  }
}
