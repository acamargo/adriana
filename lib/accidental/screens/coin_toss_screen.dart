import 'package:adriana/accidental/storage/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep_plus/flutter_beep_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:adriana/accidental/storage/matches.dart';
import 'package:adriana/essential/coin_toss.dart';
import 'package:adriana/essential/score.dart';

class CoinTossScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();
  final PreferencesStorage preferences = PreferencesStorage();
  final Map match;

  CoinTossScreen(this.match);

  @override
  _CoinTossScreenState createState() => _CoinTossScreenState();
}

class _CoinTossScreenState extends State<CoinTossScreen> {
  final _flutterBeepPlusPlugin = FlutterBeepPlus();

  String _firstServer = '';
  String _servingAtCourtEnd = '';

  bool isSound = true;
  Future<void> _loadPreferences() async {
    isSound = await widget.preferences.isSound();
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
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

  _save() {
    if (_firstServer != '' && _servingAtCourtEnd != '') {
      _storeCoinTossEvent(_firstServer, _servingAtCourtEnd).then((_) {
        if (isSound) {
          _flutterBeepPlusPlugin.playSysSound(AndroidSoundID.TONE_PROP_ACK);
        }
        Navigator.of(context).pop('coinToss');
      });
    } else {
      if (isSound)
        _flutterBeepPlusPlugin.playSysSound(AndroidSoundID.TONE_PROP_BEEP);
    }
  }

  List<Widget> _chooseFirstServer() {
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: [
            choiceChip(
                label: '${widget.match['p1']} serves first',
                selected: _firstServer == 'p1',
                onSelected: (bool selected) {
                  setState(() {
                    _firstServer = 'p1';
                    _save();
                  });
                }),
            choiceChip(
                label: '${widget.match['p2']} serves first',
                selected: _firstServer == 'p2',
                onSelected: (bool selected) {
                  setState(() {
                    _firstServer = 'p2';
                    _save();
                  });
                }),
          ],
        ),
      ),
    ];
  }

  List<Widget> _chooseServerSideOfTheCourt() {
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: [
            choiceChip(
                label: 'Left end',
                selected: _servingAtCourtEnd == 'L',
                onSelected: (bool selected) {
                  setState(() {
                    _servingAtCourtEnd = 'L';
                    _save();
                  });
                }),
            choiceChip(
                label: 'Right end',
                selected: _servingAtCourtEnd == 'R',
                onSelected: (bool selected) {
                  setState(() {
                    _servingAtCourtEnd = 'R';
                    _save();
                  });
                }),
          ],
        ),
      ),
    ];
  }

  _storeCoinTossEvent(winner, courtEnd) async {
    Map coinTossEvent = newCoinTossEvent(
        winner: winner, courtEnd: courtEnd, createdAt: DateTime.now());
    Map scoreEvent = newScoreFromCoinToss(widget.match, coinTossEvent);
    widget.match['events'].add(coinTossEvent);
    widget.match['events'].add(scoreEvent);
    return widget.storage.create(widget.match);
  }

  @override
  Widget build(BuildContext context) {
    WakelockPlus.enable();

    return Scaffold(
      appBar: AppBar(
        title: Text("Coin toss"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _chooseFirstServer() + _chooseServerSideOfTheCourt(),
        ),
      ),
    );
  }
}
