import 'package:flutter/material.dart';

import '../matches_storage.dart';
import 'point_screen.dart';

class CoinTossScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();
  final Map match;

  CoinTossScreen(this.match);

  @override
  _CoinTossScreenState createState() => _CoinTossScreenState();
}

class _CoinTossScreenState extends State<CoinTossScreen> {
  Map buildScoreFromCoinToss(previousScore, coinToss) {
    Map newScore = {...previousScore};
    newScore['createdAt'] = DateTime.now();
    newScore['server'] = coinToss['server'];
    newScore['isServiceFault'] = false;
    newScore['courtSide'] = 'deuce';
    newScore['state'] = 'first service, ${widget.match[newScore['server']]}';
    return newScore;
  }

  _storeCoinTossEvent(winner) {
    Map coinTossEvent = {
      'event': 'CoinToss',
      'createdAt': DateTime.now(),
      'server': winner,
    };
    Map scoreEvent =
        buildScoreFromCoinToss(widget.match['events'].last, coinTossEvent);
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
