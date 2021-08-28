import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wakelock/wakelock.dart';

import '../matches_storage.dart';
import 'new_match_screen.dart';
import 'point_screen.dart';
import 'coin_toss_screen.dart';
import 'stats_screen.dart';
import '../models/match.dart';

class MatchesScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List _matches = [];

  void _add() async {
    Match? results = await Navigator.of(context).push(MaterialPageRoute<Match>(
        builder: (BuildContext context) {
          return NewMatchScreen();
        },
        fullscreenDialog: true));
    if (results != null) {
      widget.storage.create({
        'createdAt': DateTime.now(),
        'p1': results.p1,
        'p2': results.p2,
        'surface': results.surface,
        'venue': results.venue,
        'events': [
          {
            'event': 'Score',
            'createdAt': DateTime.now(),
            'pointNumber': 0,
            'p1': [
              {'game': '0', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '0', 'tiebreak': null, 'set': 0}
            ],
            'state': 'waiting coin toss',
          },
        ],
      });
      widget.storage.loadAll().then((matches) {
        setState(() {
          _matches = matches;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.storage.loadAll().then((matches) {
      setState(() {
        _matches = matches;
      });
    });
  }

  String _formatDateTime(DateTime asOf) {
    final now = DateTime.now();
    final difference = DateTime(asOf.year, asOf.month, asOf.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (difference == 0) {
      return DateFormat("Hm").format(asOf);
    } else if (difference == -1) {
      return "Yesterday";
    }
    return DateFormat("yyyy-MM-dd").format(asOf);
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.disable();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
      ),
      body: ListView.builder(
        itemCount: _matches.length,
        itemBuilder: (context, index) {
          final match = _matches[index];

          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  if (match['events'].last['event'] == 'FinalScore') {
                    return StatsScreen(match);
                  }
                  bool hasCoinToss = match['events']
                      .where((event) => event['event'] == 'CoinToss')
                      .isNotEmpty;
                  return hasCoinToss
                      ? PointScreen(match)
                      : CoinTossScreen(match);
                }));
              },
              title: Text(
                  '${match['p1']} vs ${match['p2']} - ${_formatDateTime(match['createdAt'])}'),
              subtitle: Text(
                  '${match['surface']} - ${match['venue']} - ${match['events'].last['state']}'),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Add match',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
