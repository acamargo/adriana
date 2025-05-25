import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:adriana/accidental/storage/preferences.dart';
import 'package:adriana/accidental/storage/matches.dart';
import 'stats_screen.dart';
import 'package:adriana/essential/score.dart';
import 'package:adriana/essential/rally.dart';

class PointScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();
  final PreferencesStorage preferences = PreferencesStorage();
  final Map match;

  PointScreen(this.match);

  @override
  _PointScreenState createState() => _PointScreenState();
}

class TTSService {
  static final TTSService _instance = TTSService._internal();
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  List<String> speakQueue = [];
  bool _isInitialized = false;
  final String instanceId = DateTime.now().millisecondsSinceEpoch.toString();

  factory TTSService() {
    return _instance;
  }

  TTSService._internal() {
    _initTTS();
  }

  TTSService.createNewInstance() : this._internal();

  String getInstanceId() {
    return instanceId;
  }

  Future<void> _initTTS() async {
    if (_isInitialized) return;

    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    flutterTts.setCompletionHandler(() {
      isSpeaking = false;
      _processQueue();
    });

    _isInitialized = true;
    print('TTSService initialized with ID: $instanceId');
  }

  Future<void> speak(String text) async {
    speakQueue.add(text);

    if (!isSpeaking) {
      _processQueue();
    }
  }

  Future<void> _processQueue() async {
    if (speakQueue.isEmpty) return;

    isSpeaking = true;
    String textToSpeak = speakQueue.removeAt(0);
    await flutterTts.speak(textToSpeak);
  }

  Future<void> stop() async {
    speakQueue.clear();
    await flutterTts.stop();
    isSpeaking = false;
  }
}

class _PointScreenState extends State<PointScreen> {
  final TTSService tts = TTSService();

  String _player = '';
  String _shot = '';
  String _direction = '';
  String _depth = '';

  bool isSound = true;
  Future<void> _loadPreferences() async {
    isSound = await widget.preferences.isSound();
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    print('Using TTSService instance: ${tts.getInstanceId()}');
  }

  _storeRallyEvent() async {
    Map rallyEvent = newRallyEvent(
        createdAt: DateTime.now(),
        match: widget.match,
        player: _player,
        shot: _shot,
        direction: _direction,
        depth: _depth);
    Map scoreEvent = newScoreFromRally(
        DateTime.now(), widget.match, widget.match['events'].last, rallyEvent);

    widget.match['events'].add(rallyEvent);
    widget.match['events'].add(scoreEvent);
    return widget.storage.create(widget.match);
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
      case 'Enable sound':
        await widget.preferences.setSound(true);
        isSound = true;
        break;
      case 'Disable sound':
        await widget.preferences.setSound(false);
        isSound = false;
        break;
      case 'Stats':
        var result = await openStatsSpreadsheet(match: widget.match);
        if (result.type != ResultType.done)
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result.message)));
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
          widget.storage
              .create(widget.match)
              .then((_) => Navigator.of(context).pop('finish'));
        }
        break;
    }
  }

  bool _undoCoinTossAllowed() {
    final events = widget.match['events'];
    final length = events.length;
    return events[length - 2]['event'] == 'CoinToss' &&
        events[length - 1]['event'] == 'Score';
  }

  void handleCoinTossUndo() async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${widget.match['p1']} vs ${widget.match['p2']}"),
          content: Text("Would you like to undo the coin toss?"),
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
      widget.storage
          .create(widget.match)
          .then((_) => Navigator.of(context).pop('undoCoinToss'));
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
      widget.storage
          .create(widget.match)
          .then((_) => Navigator.of(context).pop('undo'));
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
                  if (isSound) tts.speak(widget.match['p1']);
                  setState(() {
                    _player = 'p1';
                    _save();
                  });
                }),
            choiceChip(
                label: widget.match['p2'],
                selected: _player == 'p2',
                onSelected: (bool selected) {
                  if (isSound) tts.speak(widget.match['p2']);
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
                label: item['short'],
                selected: _shot == item['value'],
                onSelected: (bool selected) {
                  if (isSound) tts.speak(item['label']);
                  setState(() {
                    _shot = item['value'];
                  });
                  _save();
                },
              )
          ],
        ),
      ),
    ];
  }

  List<Widget> _whatWasTheDirection() {
    final options = whatWasTheDirectionOptions(shot: _shot);
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: <Widget>[
            for (var item in options['options'])
              choiceChip(
                label: item['label'],
                selected: _direction == item['value'],
                onSelected: (bool selected) {
                  if (isSound) tts.speak(item['label']);
                  setState(() {
                    _direction = item['value'];
                  });
                  _save();
                },
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
                onSelected: (bool selected) {
                  if (isSound) tts.speak(item['label']);
                  setState(() {
                    _depth = item['value'];
                  });
                  _save();
                },
              )
          ],
        ),
      ),
    ];
  }

  bool switchEnds() {
    final _score = score();
    final bool isTieBreak =
        _score['p1'].last['set'] == 6 && _score['p2'].last['set'] == 6;
    if (isTieBreak) {
      final int pointsPlayed =
          _score['p1'].last['tiebreak'] + _score['p2'].last['tiebreak'];
      final bool _switchEnds = pointsPlayed > 0 && pointsPlayed % 6 == 0;
      return _switchEnds;
    }
    final int gamesPlayed = _score['p1'].last['set'] + _score['p2'].last['set'];
    final bool _switchEnds = _score['p1'].last['game'] == '0' &&
        _score['p2'].last['game'] == '0' &&
        gamesPlayed > 0 &&
        gamesPlayed % 2 != 0;
    return _switchEnds;
  }

  _save() {
    if (_player != '' && _shot != '' && _direction != '' && _depth != '') {
      _storeRallyEvent().then((_) {
        if (isSound) {
          final message = spokenScore(widget.match);
          tts.speak(message);
        }
        Navigator.of(context).pop('newEvent');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WakelockPlus.enable();

    if (_player == '') {
      _player = whoIsServing();
      if (_shot == '') _shot = 'SV';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            formatScore(widget.match, widget.match['events'].last,
                widget.match['events'].last['server']),
            style: TextStyle(color: Colors.lightGreenAccent)),
        actions: <Widget>[
          if (_undoCoinTossAllowed())
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: handleCoinTossUndo,
                  child: Icon(
                    Icons.undo,
                    size: 26.0,
                  ),
                )),
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
              return {
                isSound ? 'Disable sound' : 'Enable sound',
                'Stats',
                'Finish'
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _whoTouchedTheBallLast() +
              _whatWasTheShotHit() +
              _whatWasTheDirection() +
              _whereDidTheBallLand(),
        ),
      ),
    );
  }
}
