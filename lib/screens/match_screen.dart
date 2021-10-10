import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:open_file/open_file.dart';

import 'point_screen.dart';
import 'coin_toss_screen.dart';
import 'stats_screen.dart';
import '../logic/rally.dart';
import '../logic/score.dart';
import '../logic/stats.dart';
import '../logic/date_time.dart';

class MatchScreen extends StatefulWidget {
  final Map match;

  MatchScreen(this.match);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  void handleClick(String value) async {
    switch (value) {
      case 'Stats':
        var result = await openStatsSpreadsheet(match: widget.match);
        if (result.type != ResultType.done)
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result.message)));
        break;
      case 'Finish':
        // bool result = await showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text("${widget.match['p1']} vs ${widget.match['p2']}"),
        //       content: Text("Would you like to finish the match?"),
        //       actions: [
        //         TextButton(
        //           child: Text("YES"),
        //           onPressed: () {
        //             Navigator.of(context, rootNavigator: true).pop(true);
        //           },
        //         ),
        //         TextButton(
        //           child: Text("NO"),
        //           onPressed: () {
        //             Navigator.of(context, rootNavigator: true).pop(false);
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
        // if (result) {
        //   Map lastScore = widget.match['events'].last;
        //   Map finalScoreEvent = {
        //     'event': 'FinalScore',
        //     'createdAt': DateTime.now(),
        //     'pointNumber': lastScore['pointNumber'],
        //     'p1': lastScore['p1'],
        //     'p2': lastScore['p2'],
        //     'state': 'Match finished'
        //   };
        //   widget.match['events'].add(finalScoreEvent);
        //   widget.storage.create(widget.match);
        //   Navigator.pop(context);
        // }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();

    final events = widget.match['events'].reversed.toList();
    List<Map> items = [];
    for (var i = 0; i < widget.match['events'].length; i++) {
      final item = widget.match['events'][i];
      if (item['event'] == 'CoinToss') {
        final serverName = widget.match[item['server']];
        items.add({
          'pointNumber': '',
          'title': '$serverName to serve',
          'subtitle': '$serverName 0/0 0-0',
          'time': '',
        });
      } else if (item['event'] == 'Rally') {
        final score = widget.match['events'][i + 1];
        items.add({
          'pointNumber': score['isServiceFault']
              ? ''
              : '#${widget.match['events'][i - 1]['pointNumber'] + 1}',
          'title': formatRally(widget.match, item),
          'subtitle': formatScore(widget.match, score, score['server']),
          'time': formatTime(item['createdAt'])
        });
      } else if (item['event'] == 'FinalScore') {
        final stats = matchStats(match: widget.match);
        final matchFinishedResult =
            '${widget.match[stats['winner']]} d. ${widget.match[stats['looser']]}';
        final matchDuration = stats['match-duration'][0];
        String matchFinishedDuration =
            matchDuration.toString().split('.').first;
        String matchFinishedScore =
            statsScoreList(item, stats['winner']).join(' ');
        items.add({
          'pointNumber': '',
          'title': matchFinishedResult,
          'subtitle': '$matchFinishedScore in $matchFinishedDuration',
          'time': '',
        });
      }
    }
    items = items.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.match['p1']} vs ${widget.match['p2']}'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Share',
                'Stats',
                if (events.first['event'] != 'FinalScore') 'Finish'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

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
                // }
              },
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(item['title']), Text(item['pointNumber'])]),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(item['subtitle']), Text(item['time'])]),
            ),
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: events.first['event'] != 'FinalScore',
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              bool hasCoinToss = events
                  .where((event) => event['event'] == 'CoinToss')
                  .isNotEmpty;
              return hasCoinToss
                  ? PointScreen(widget.match)
                  : CoinTossScreen(widget.match);
            }));
          },
          tooltip: 'Add event',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
