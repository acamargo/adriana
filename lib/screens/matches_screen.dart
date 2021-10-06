import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:open_file/open_file.dart';

import '../matches_storage.dart';
import 'new_match_screen.dart';
import 'point_screen.dart';
import 'coin_toss_screen.dart';
import 'stats_screen.dart';
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

  void _add() async {
    Match? results = await Navigator.of(context).push(MaterialPageRoute<Match>(
        builder: (BuildContext context) => NewMatchScreen(),
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

  @override
  void initState() {
    super.initState();
    widget.storage.loadAll().then((matches) {
      setState(() => _matches = matches);
    });
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
                // if (match['events'].last['event'] == 'FinalScore') {
                //   openStatsSpreadsheet(match: match).then((result) {
                //     if (result.type != ResultType.done)
                //       ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(content: Text(result.message)));
                //   });
                // } else {
                //   Navigator.of(context)
                //       .push(MaterialPageRoute(builder: (context) {
                //     bool hasCoinToss = match['events']
                //         .where((event) => event['event'] == 'CoinToss')
                //         .isNotEmpty;
                //     return hasCoinToss
                //         ? PointScreen(match)
                //         : CoinTossScreen(match);
                //   }));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MatchScreen(match);
                }));
              },
              title: Text(
                  '${match['p1']} vs ${match['p2']} - ${formatDateTime(match['createdAt'], DateTime.now())}'),
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
