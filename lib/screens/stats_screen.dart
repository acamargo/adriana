import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';
import '../logic/stats.dart';

// set time
// aces
// double faults
// first serve %
// win % on 1st serve
// win % on 2nd serve
// break points
// winners
// unforced errors
// net points won
// total points won

void statsSheet({required sheet, required Map stats}) {
  sheet.appendRow(['Training session statistics']);
  sheet.appendRow(['Score', stats['score']]);
  sheet.appendRow(['Training time', stats['match-time']]);
  sheet.appendRow(['', stats['p1']['name'], stats['p2']['name']]);
  for (var i = 0; i < stats['p1']['results'].length; i++) {
    sheet.appendRow((i == 0) ? ['Overall'] : ['Set $i']);
    sheet.appendRow([
      'Points played',
      stats['p1']['results'][i]['points-played'],
      stats['p2']['results'][i]['points-played']
    ]);
    sheet.appendRow([
      'Points win',
      stats['p1']['results'][i]['points-win'],
      stats['p2']['results'][i]['points-win']
    ]);
    sheet.appendRow([
      'Points win %',
      stats['p1']['results'][i]['points-win-%'],
      stats['p2']['results'][i]['points-win-%']
    ]);
    sheet.appendRow([
      'Aces',
      stats['p1']['results'][i]['aces'],
      stats['p2']['results'][i]['aces']
    ]);
    sheet.appendRow([
      'Double faults',
      stats['p1']['results'][i]['double-faults'],
      stats['p2']['results'][i]['double-faults']
    ]);
    sheet.appendRow([
      '1st serve points played',
      stats['p1']['results'][i]['1st-serve-played'],
      stats['p2']['results'][i]['1st-serve-played']
    ]);
    sheet.appendRow([
      '1st serve points win',
      stats['p1']['results'][i]['1st-serve-win'],
      stats['p2']['results'][i]['1st-serve-win']
    ]);
    sheet.appendRow([
      '1st serve points win %',
      stats['p1']['results'][i]['1st-serve-win-%'],
      stats['p2']['results'][i]['1st-serve-win-%']
    ]);
    sheet.appendRow([
      '2nd serve points played',
      stats['p1']['results'][i]['2nd-serve-played'],
      stats['p2']['results'][i]['2nd-serve-played']
    ]);
    sheet.appendRow([
      '2nd serve points win',
      stats['p1']['results'][i]['2nd-serve-win'],
      stats['p2']['results'][i]['2nd-serve-win']
    ]);
    sheet.appendRow([
      '2nd serve points win %',
      stats['p1']['results'][i]['2nd-serve-win-%'],
      stats['p2']['results'][i]['2nd-serve-win-%']
    ]);
    sheet.appendRow([
      'Game points played',
      stats['p1']['results'][i]['game-points-played'],
      stats['p2']['results'][i]['game-points-played']
    ]);
    sheet.appendRow([
      'Game points win',
      stats['p1']['results'][i]['game-points-win'],
      stats['p2']['results'][i]['game-points-win']
    ]);
    sheet.appendRow([
      'Game points win %',
      stats['p1']['results'][i]['game-points-win-%'],
      stats['p2']['results'][i]['game-points-win-%']
    ]);
    sheet.appendRow([
      'Break points played',
      stats['p1']['results'][i]['break-points-played'],
      stats['p2']['results'][i]['break-points-played']
    ]);
    sheet.appendRow([
      'Break points win',
      stats['p1']['results'][i]['break-points-win'],
      stats['p2']['results'][i]['break-points-win']
    ]);
    sheet.appendRow([
      'Break points win %',
      stats['p1']['results'][i]['break-points-win-%'],
      stats['p2']['results'][i]['break-points-win-%']
    ]);
  }
}

void timelineSheet({required sheet, required match}) {
  final shots = {
    'FH': 'Forehand',
    'BH': 'Backhand',
    'SV': 'Serve',
    'SM': 'Smash',
    'V': 'Volley'
  };
  final depths = {
    'I': 'Winner',
    'O': 'Out',
    'N': 'Into the net',
  };
  var row = [
    'Time',
    'Point Number',
    'Event',
    'Server',
    'Decider',
    'Shot',
    'Call',
    'Points ${match['p1']}',
    'Points ${match['p2']}'
  ];
  final numberOfSets = match['events'].last['p1'].length;
  for (var i = 0; i < numberOfSets; i++) {
    row.add('Set ${i + 1} ${match['p1']}');
    row.add('Set ${i + 1} ${match['p2']}');
  }
  sheet.appendRow(row);

  for (int index = 0; index < match['events'].length; index++) {
    final event = match['events'][index];
    var row = [
      event['createdAt'].toIso8601String(),
      event['pointNumber'],
      event['event'],
    ];
    if (event['event'] == 'CoinToss') {
      row.addAll([match[event['server']]]);
    } else if (event['event'] == 'Score' || event['event'] == 'FinalScore') {
      row.addAll(['', '', '', '']);
      final p1Sets = event['p1'];
      final numberOfSets = p1Sets.length;
      row.add(p1Sets.last['game']);

      final p2Sets = event['p2'];
      row.add(p2Sets.last['game']);

      for (var i = 0; i < numberOfSets; i++) {
        row.add(p1Sets[i]['set']);
        row.add(p2Sets[i]['set']);
      }
    } else if (event['event'] == 'Rally') {
      row.addAll([
        match[event['server']],
        match[event['lastHitBy']],
        shots[event['shot']],
        (event['server'] == event['lastHitBy'] &&
                event['shot'] == 'SV' &&
                event['depth'] == 'I')
            ? 'Ace'
            : depths[event['depth']]
      ]);
    }
    sheet.appendRow(row);
  }
}

void report({required Map match}) async {
  var excel =
      Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1

  excel.rename('Sheet1', 'Timeline');

  timelineSheet(sheet: excel['Timeline'], match: match);
  statsSheet(sheet: excel['Stats'], stats: matchStats(match: match));

  var fileBytes = excel.save();
  var directory = await getApplicationDocumentsDirectory();
  final fileName = match['createdAt'].toIso8601String();
  final filePath = "${directory.path}/$fileName.match.xlsx";

  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes as List<int>);

  final _result = await OpenFile.open(filePath);
  print(_result.message);
}

class StatsScreen extends StatefulWidget {
  final match;

  StatsScreen(this.match);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Stats'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('${widget.match['p1']} vs ${widget.match['p2']}'),
            ElevatedButton(
              onPressed: () {
                report(match: widget.match);
              },
              child: Text('Open report'),
            )
          ],
        ),
      ),
    );
  }
}

// time played
// time point average

// |  24 points played in the match                                                                                                        |
// | 10 decided by p1 (1 hits/9 misses)                                                                                 | 14 decided by p2 |
// | 2 serve      | 6 forehand               | 2 backhand               | 0 volley              | 0 smash               |
// | 0 ace | 2 DF | 1 winner | 3 net | 2 out | 0 winner | 2 net | 0 out | 0 win | 0 net | 0 out | 0 win | 0 net | 0 out |

// points | total  | 1st set | 2nd set | 3rd set
// -------+--------+---------+---------+--------
// match  | 143    | 64      | 55      | 24
// p1     | 30/113 | 10/54
// p2     | 113/30 | 54/10
// * points
//    * number of points played/won/lost
//    * points won/lost by stroke
// * games
//   * number of games played/won/lost
//   * number of games played serving/won/lost
//   * number of games played receiving/won/lost
// * forehand
//   * overall number of hit/winner/into the net/out
// * backhand
//   * overall number of hit/winner/into the net/out
// * smash
//   * overall number of hit/winner/into the net/out
// * volley
//   * overall number of hit/winner/into the net/out
// * service
//   * overall number of services hit/ace/into the net/out
//   * 1st service 
//     * consistency (how many times the ball was in / the ball was into the net or out)
//     * points won (number of points won when the first serve was in / number of times the first serve was in)
//     * unreturned serves (number of times the opponent returned into the net or out / number of time the first serve was in)
//   * 2st service 
//     * consistency (how many times the ball was in / the ball was into the net or out)
//     * points won (number of points won when the first serve was in / number of times the first serve was in)
//     * unreturned serves (number of times the opponent returned into the net or out / number of time the first serve was in)
// 