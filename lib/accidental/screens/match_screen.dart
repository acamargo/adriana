import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

import 'point_screen.dart';
import 'coin_toss_screen.dart';
import 'stats_screen.dart';
import 'new_match_screen.dart';
import 'package:adriana/accidental/storage/matches.dart';
import 'package:adriana/accidental/models/match.dart';
import 'package:adriana/essential/rally.dart';
import 'package:adriana/essential/match.dart';
import 'package:adriana/essential/score.dart';
import 'package:adriana/essential/stats.dart';
import 'package:adriana/accidental/logic/date_time.dart';

class MatchScreen extends StatefulWidget {
  final Map match;

  MatchScreen(this.match);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  void handleClick(String value) async {
    switch (value) {
      case 'Edit':
        Match? results = await Navigator.of(context).push(
            MaterialPageRoute<Match>(
                builder: (BuildContext context) => NewMatchScreen(widget.match),
                fullscreenDialog: true));
        if (results != null) {
          widget.match['p1'] = results.p1;
          widget.match['p2'] = results.p2;
          widget.match['surface'] = results.surface;
          widget.match['venue'] = results.venue;
          MatchesStorage().create(widget.match);
          setState(() {});
        }
        break;
      case 'Rematch':
        bool result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${widget.match['p1']} vs ${widget.match['p2']}"),
              content:
                  Text("Would you like to create a new match from this one?"),
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
          final match = newMatch(
              createdAt: DateTime.now(),
              p1: widget.match['p1'],
              p2: widget.match['p2'],
              surface: widget.match['surface'],
              venue: widget.match['venue']);
          final File matchFile = await MatchesStorage().create(match);
          Navigator.of(context).pop(
              matchFile); // Returns to MatchesScreen providing the file created
        }
        break;
      case 'Delete':
        bool result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${widget.match['p1']} vs ${widget.match['p2']}"),
              content: Text("Would you like to delete the match?"),
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
          await MatchesStorage().delete(widget.match);
          Navigator.pop(context);
        }
        break;
      case 'Share stats':
        generateStatsSpreadsheet(match: widget.match);
        final box = context.findRenderObject() as RenderBox?;
        final filePath = await statsSpreadsheetFilename(match: widget.match);
        final description =
            '${widget.match['p1']} vs ${widget.match['p2']} tennis match stats';
        await Share.shareFiles([filePath],
            mimeTypes: ['application/vnd.ms-excel'],
            text: description,
            subject: description,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
        break;
      case 'Open stats':
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
          MatchesStorage()
              .create(widget.match)
              .then((_) => Navigator.pop(context));
        }
        break;
    }
  }

  List<Map> _history() {
    List<Map> items = [];
    for (var i = 0; i < widget.match['events'].length; i++) {
      final item = widget.match['events'][i];
      if (item['event'] == 'CoinToss') {
        final serverName = widget.match[item['server']];
        final serverEnd = item['courtEnd'];
        items.add({
          'pointNumber': '',
          'title': serverEnd == 'L'
              ? '$serverName to serve at Left end'
              : (serverEnd == 'R'
                  ? '$serverName to serve at Right end'
                  : '$serverName to serve'),
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
            '${widget.match[stats['winner']]} d. ${widget.match[stats['loser']]}';
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
    return items.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    WakelockPlus.disable();

    final events = widget.match['events'].reversed.toList();
    List<Map> items = _history();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.match['p1']} vs ${widget.match['p2']}'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Edit',
                'Rematch',
                'Delete',
                if (items.isNotEmpty) 'Share stats',
                if (items.isNotEmpty) 'Open stats',
                if (items.isNotEmpty && events.first['event'] != 'FinalScore')
                  'Finish'
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
      body: items.isEmpty
          ? Center(child: Text('Tap "+" to start the match.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Card(
                  child: ListTile(
                    title: item['pointNumber'].isEmpty
                        ? Text(item['title'])
                        : Row(mainAxisSize: MainAxisSize.max, children: [
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  item['title'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              alignment: Alignment.centerRight,
                              child: Text(item['pointNumber']),
                            )
                          ]),
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
          onPressed: addEvent,
          tooltip: 'Add event',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  addEvent() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      bool hasCoinToss = widget.match['events']
          .where((event) => event['event'] == 'CoinToss')
          .isNotEmpty;
      return hasCoinToss
          ? PointScreen(widget.match)
          : CoinTossScreen(widget.match);
    })).then((eventName) {
      if (eventName == null || eventName == 'finish') {
        // back button pressed or finish action selected in point screen
        setState(() {});
      } else {
        addEvent();
      }
    });
  }
}
