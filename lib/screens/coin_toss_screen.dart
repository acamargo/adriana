import 'package:flutter/material.dart';

import '../matches_storage.dart';
import 'point_screen.dart';
import '../logic/coin_toss.dart';

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
    widget.storage.create(widget.match);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => PointScreen(widget.match)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.match['p1']} vs ${widget.match['p2']}"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Coin toss"),
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
