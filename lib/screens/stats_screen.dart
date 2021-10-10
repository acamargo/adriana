import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';
import '../logic/stats.dart';
import '../logic/score.dart';
import '../logic/date_time.dart';
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

// service stats *
// serve rating
// aces
// double faults
// 1st serve
// 1st serve points won
// 2nd serve points won
// break points saved
// service games played
// return stats *
// return rating
// 1st serve return points won
// 2nd serve return points won
// break points converted
// return games played
// point stats *
// service points won
// return points won
// total points won: 47% (64/137)

void statsSheet(
    {required spreadsheet, required Map stats, required Map match}) {
  final matchWinner = stats['p1']['results'][0]['points-win'] >=
          stats['p2']['results'][0]['points-win']
      ? 'p1'
      : 'p2';
  for (var i = 0; i < stats['p1']['results'].length; i++) {
    final title = (i == 0) ? 'Overall' : 'Set $i';
    var sheet = spreadsheet[title];
    sheet.appendRow(['Players', '${match['p1']} vs ${match['p2']}']);
    sheet.appendRow(['Court surface', match['surface']]);
    sheet.appendRow(['Venue', match['venue']]);
    sheet.appendRow([
      'Date',
      formatStatsWeekday(match['createdAt']),
      match['createdAt'].toString().split('.').first
    ]);
    sheet.appendRow(['']);
    sheet.appendRow([title]);
    sheet.appendRow([
      'Score',
      (i == 0)
          ? formatStatsScore(match, match['events'].last, matchWinner)
          : formatStatsSet(match['p1'], match['p2'], stats['scores'][i])
    ]);
    sheet.appendRow(
        ['Duration', stats['match-duration'][i].toString().split('.').first]);
    sheet.appendRow(['']);
    sheet.appendRow(['Point Stats', stats['p1']['name'], stats['p2']['name']]);
    sheet.appendRow([
      'Played',
      stats['p1']['results'][i]['points-played'],
      stats['p2']['results'][i]['points-played']
    ]);

    sheet.appendRow([
      'Total won',
      stats['p1']['results'][i]['points-win'],
      stats['p2']['results'][i]['points-win']
    ]);
    sheet.appendRow([
      'Total won %',
      stats['p1']['results'][i]['points-win-%'],
      stats['p2']['results'][i]['points-win-%']
    ]);
    // sheet.appendRow(['Service points played']);
    // sheet.appendRow(['Service points won']);
    // sheet.appendRow(['Service points won %']);
    // sheet.appendRow(['Return points played']);
    // sheet.appendRow(['Return points won']);
    // sheet.appendRow(['Return points won %']);

    sheet.appendRow(['']);
    sheet.appendRow(['Serve Stats', stats['p1']['name'], stats['p2']['name']]);
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
    // sheet.appendRow([
    //   'Game points played',
    //   stats['p1']['results'][i]['game-points-played'],
    //   stats['p2']['results'][i]['game-points-played']
    // ]);
    // sheet.appendRow([
    //   'Game points win',
    //   stats['p1']['results'][i]['game-points-win'],
    //   stats['p2']['results'][i]['game-points-win']
    // ]);
    // sheet.appendRow([
    //   'Game points win %',
    //   stats['p1']['results'][i]['game-points-win-%'],
    //   stats['p2']['results'][i]['game-points-win-%']
    // ]);
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

    sheet.appendRow(['']);
    sheet.appendRow(
        ['Forehand Stats', stats['p1']['name'], stats['p2']['name']]);
    sheet.appendRow([
      'Total points decided with',
      stats['p1']['results'][i]['forehand-played'],
      stats['p2']['results'][i]['forehand-played']
    ]);
    sheet.appendRow([
      'Winners',
      stats['p1']['results'][i]['forehand-win'],
      stats['p2']['results'][i]['forehand-win']
    ]);
    sheet.appendRow([
      'Winners %',
      stats['p1']['results'][i]['forehand-win-%'],
      stats['p2']['results'][i]['forehand-win-%']
    ]);
    sheet.appendRow([
      'Into the net',
      stats['p1']['results'][i]['forehand-net'],
      stats['p2']['results'][i]['forehand-net']
    ]);
    sheet.appendRow([
      'Into the net %',
      stats['p1']['results'][i]['forehand-net-%'],
      stats['p2']['results'][i]['forehand-net-%']
    ]);
    sheet.appendRow([
      'Out',
      stats['p1']['results'][i]['forehand-out'],
      stats['p2']['results'][i]['forehand-out']
    ]);
    sheet.appendRow([
      'Out %',
      stats['p1']['results'][i]['forehand-out-%'],
      stats['p2']['results'][i]['forehand-out-%']
    ]);

    sheet.appendRow(['']);
    sheet.appendRow(
        ['Backhand Stats', stats['p1']['name'], stats['p2']['name']]);
    sheet.appendRow([
      'Total points decided with',
      stats['p1']['results'][i]['backhand-played'],
      stats['p2']['results'][i]['backhand-played']
    ]);
    sheet.appendRow([
      'Winners',
      stats['p1']['results'][i]['backhand-win'],
      stats['p2']['results'][i]['backhand-win']
    ]);
    sheet.appendRow([
      'Winners %',
      stats['p1']['results'][i]['backhand-win-%'],
      stats['p2']['results'][i]['backhand-win-%']
    ]);
    sheet.appendRow([
      'Into the net',
      stats['p1']['results'][i]['backhand-net'],
      stats['p2']['results'][i]['backhand-net']
    ]);
    sheet.appendRow([
      'Into the net %',
      stats['p1']['results'][i]['backhand-net-%'],
      stats['p2']['results'][i]['backhand-net-%']
    ]);
    sheet.appendRow([
      'Out',
      stats['p1']['results'][i]['backhand-out'],
      stats['p2']['results'][i]['backhand-out']
    ]);
    sheet.appendRow([
      'Out %',
      stats['p1']['results'][i]['backhand-out-%'],
      stats['p2']['results'][i]['backhand-out-%']
    ]);

    sheet.appendRow(['']);
    sheet.appendRow(['Volley Stats', stats['p1']['name'], stats['p2']['name']]);
    sheet.appendRow([
      'Total points decided with',
      stats['p1']['results'][i]['volley-played'],
      stats['p2']['results'][i]['volley-played']
    ]);
    sheet.appendRow([
      'Winners',
      stats['p1']['results'][i]['volley-win'],
      stats['p2']['results'][i]['volley-win']
    ]);
    sheet.appendRow([
      'Winners %',
      stats['p1']['results'][i]['volley-win-%'],
      stats['p2']['results'][i]['volley-win-%']
    ]);
    sheet.appendRow([
      'Into the net',
      stats['p1']['results'][i]['volley-net'],
      stats['p2']['results'][i]['volley-net']
    ]);
    sheet.appendRow([
      'Into the net %',
      stats['p1']['results'][i]['volley-net-%'],
      stats['p2']['results'][i]['volley-net-%']
    ]);
    sheet.appendRow([
      'Out',
      stats['p1']['results'][i]['volley-out'],
      stats['p2']['results'][i]['volley-out']
    ]);
    sheet.appendRow([
      'Out %',
      stats['p1']['results'][i]['volley-out-%'],
      stats['p2']['results'][i]['volley-out-%']
    ]);

    sheet.appendRow(['']);
    sheet.appendRow(['Smash Stats', stats['p1']['name'], stats['p2']['name']]);
    sheet.appendRow([
      'Total points decided with',
      stats['p1']['results'][i]['smash-played'],
      stats['p2']['results'][i]['smash-played']
    ]);
    sheet.appendRow([
      'Winners',
      stats['p1']['results'][i]['smash-win'],
      stats['p2']['results'][i]['smash-win']
    ]);
    sheet.appendRow([
      'Winners %',
      stats['p1']['results'][i]['smash-win-%'],
      stats['p2']['results'][i]['smash-win-%']
    ]);
    sheet.appendRow([
      'Into the net',
      stats['p1']['results'][i]['smash-net'],
      stats['p2']['results'][i]['smash-net']
    ]);
    sheet.appendRow([
      'Into the net %',
      stats['p1']['results'][i]['smash-net-%'],
      stats['p2']['results'][i]['smash-net-%']
    ]);
    sheet.appendRow([
      'Out',
      stats['p1']['results'][i]['smash-out'],
      stats['p2']['results'][i]['smash-out']
    ]);
    sheet.appendRow([
      'Out %',
      stats['p1']['results'][i]['smash-out-%'],
      stats['p2']['results'][i]['smash-out-%']
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
    'Winner',
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
      row.addAll(['', '', '', '', '']);
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
            : depths[event['depth']],
        event['winner'] == null ? 'FAULT' : match[event['winner']]
      ]);
    }
    sheet.appendRow(row);
  }
}

Future<String> statsSpreadsheetFilename({required Map match}) async {
  var directory = await getApplicationDocumentsDirectory();
  final fileName = match['createdAt'].toIso8601String();
  final filePath = "${directory.path}/$fileName.match.xlsx";
  return filePath;
}

void generateStatsSpreadsheet({required Map match}) async {
  var excel =
      Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1

  statsSheet(spreadsheet: excel, stats: matchStats(match: match), match: match);
  timelineSheet(sheet: excel['Timeline'], match: match);

  excel.delete('Sheet1');

  var fileBytes = excel.save();
  final filePath = await statsSpreadsheetFilename(match: match);

  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes as List<int>);
}

Future<OpenResult> openStatsSpreadsheet({required Map match}) async {
  generateStatsSpreadsheet(match: match);
  final filePath = await statsSpreadsheetFilename(match: match);
  final result = await OpenFile.open(filePath);
  return result;
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
                generateStatsSpreadsheet(match: widget.match);
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