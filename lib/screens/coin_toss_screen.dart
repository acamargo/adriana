import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../accidental/storage/matches.dart';
import '../logic/coin_toss.dart';
import '../logic/score.dart';

class CoinTossScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();
  final Map match;

  CoinTossScreen(this.match);

  @override
  _CoinTossScreenState createState() => _CoinTossScreenState();
}

class _CoinTossScreenState extends State<CoinTossScreen> {
  _storeCoinTossEvent(winner) {
    Map coinTossEvent =
        newCoinTossEvent(winner: winner, createdAt: DateTime.now());
    Map scoreEvent = newScoreFromCoinToss(widget.match, coinTossEvent);
    widget.match['events'].add(coinTossEvent);
    widget.match['events'].add(scoreEvent);
    widget.storage
        .create(widget.match)
        .then((_) => Navigator.of(context).pop('coinToss'));
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();

    return Scaffold(
      appBar: AppBar(
        title: Text("Coin toss"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _storeCoinTossEvent('p1');
              },
              child: Text('${widget.match['p1']} serves first'),
            ),
            ElevatedButton(
              onPressed: () {
                _storeCoinTossEvent('p2');
              },
              child: Text('${widget.match['p2']} serves first'),
            )
          ],
        ),
      ),
    );
  }
}
