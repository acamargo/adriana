import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';

// match statistics
// aces
// double faults
// first serve %
// win % on 1st serve
// win % on 2nd serve
// break points

// set time
// 1st serve %
// aces
// double faults
// winners
// unforced errors
// break point errors
// net points won
// total points won

// double faults
// winners
// unforced errors
// break points won
// net points won
// total points won
// aces
// 1st serve %
// 2nd serve pts won %

// 1st set
// P1: won 20 of 21 service points
// P2: broken for 1st time since First Round (won previous 66 straight service games)
// P2: 1st set lost in tournament
// P1 vs P2: winner of 1st set won last 10 meetings

void statsSheet({required sheet}) {
  Map stats = {
    'score': 'P1 6-2 6-2',
    'match-time': '1:23',
    'p1': {
      'name': 'P1',
      'results': [
        {
          'points-played': 2,
          'points-win': 1,
          'points-win-%': 50,
          'aces': 1,
          'double-faults': 1,
          '1st-serve-played': 10,
          '1st-serve-win': 2,
          '1st-serve-win-%': 20,
          '2nd-serve-played': 10,
          '2nd-serve-win': 3,
          '2nd-serve-win-%': 30,
          'break-points-played': 10,
          'break-points-win': 4,
          'break-point-win-%': 40,
          'game-points-played': 10,
          'game-points-win': 5,
          'game-points-win-%': 50,
        },
        {
          'points-played': 2,
          'points-win': 1,
          'points-win-%': 50,
          'aces': 1,
          'double-faults': 1,
          '1st-serve-played': 10,
          '1st-serve-win': 2,
          '1st-serve-win-%': 20,
          '2nd-serve-played': 10,
          '2nd-serve-win': 3,
          '2nd-serve-win-%': 30,
          'break-points-played': 10,
          'break-points-win': 4,
          'break-point-win-%': 40,
          'game-points-played': 10,
          'game-points-win': 5,
          'game-points-win-%': 50,
        }
      ]
    },
    'p2': {
      'name': 'P2',
      'results': [
        {
          'points-played': 2,
          'points-win': 1,
          'points-win-%': 50,
          'aces': 1,
          'double-faults': 1,
          '1st-serve-played': 10,
          '1st-serve-win': 2,
          '1st-serve-win-%': 20,
          '2nd-serve-played': 10,
          '2nd-serve-win': 3,
          '2nd-serve-win-%': 30,
          'break-points-played': 10,
          'break-points-win': 4,
          'break-point-win-%': 40,
          'game-points-played': 10,
          'game-points-win': 5,
          'game-points-win-%': 50,
        },
        {
          'points-played': 2,
          'points-win': 1,
          'points-win-%': 50,
          'aces': 1,
          'double-faults': 1,
          '1st-serve-played': 10,
          '1st-serve-win': 2,
          '1st-serve-win-%': 20,
          '2nd-serve-played': 10,
          '2nd-serve-win': 3,
          '2nd-serve-win-%': 30,
          'break-points-played': 10,
          'break-points-win': 4,
          'break-point-win-%': 40,
          'game-points-played': 10,
          'game-points-win': 5,
          'game-points-win-%': 50,
        }
      ]
    }
  };
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
  }
}

void report({required Map match}) async {
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
  var excel =
      Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1

  excel.rename('Sheet1', 'Timeline');

  var timeline = excel['Timeline'];
  var row = 1;
  var column = 65; // A character in ASCII
  timeline
      .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
      .value = 'Time';
  column++;
  timeline
      .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
      .value = 'Server';
  column++;
  timeline
      .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
      .value = 'Decider';
  column++;
  timeline
      .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
      .value = 'Shot';
  column++;
  timeline
      .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
      .value = 'Call';
  column++;
  timeline
      .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
      .value = 'Points ${match['p1']}';
  column++;
  timeline
      .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
      .value = 'Points ${match['p2']}';
  column++;
  final numberOfSets = match['events'].last['p1'].length;
  for (var i = 0; i < numberOfSets; i++) {
    timeline
        .cell(CellIndex.indexByString(
            '${String.fromCharCode(column + (2 * i))}$row'))
        .value = 'Set ${i + 1} ${match['p1']}';
    timeline
        .cell(CellIndex.indexByString(
            '${String.fromCharCode(column + (2 * i) + 1)}$row'))
        .value = 'Set ${i + 1} ${match['p2']}';
  }

  for (int index = 0; index < match['events'].length; index++) {
    final event = match['events'][index];
    var column = 65; // "A" character in ASCII
    if (event['event'] == 'CoinToss') {
      row++;
      timeline.cell(CellIndex.indexByString('A$row')).value =
          event['createdAt'].toIso8601String();
      timeline.cell(CellIndex.indexByString('B$row')).value =
          match[event['server']];
      timeline.cell(CellIndex.indexByString('F$row')).value = '0';
      timeline.cell(CellIndex.indexByString('G$row')).value = '0';
      timeline.cell(CellIndex.indexByString('H$row')).value = 0;
      timeline.cell(CellIndex.indexByString('I$row')).value = 0;
    } else if (event['event'] == 'Rally') {
      row++;
      timeline
          .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
          .value = event['createdAt'].toIso8601String();
      column++;
      timeline
          .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
          .value = match[event['server']];
      column++;
      timeline
          .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
          .value = match[event['lastHitBy']];
      column++;
      timeline
          .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
          .value = shots[event['shot']];
      column++;
      timeline
          .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
          .value = depths[event['depth']];
      if (event['server'] == event['lastHitBy'] &&
          event['shot'] == 'SV' &&
          event['depth'] == 'I')
        timeline
            .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
            .value = 'Ace';

      final score = match['events'][index + 1];
      final p1Sets = score['p1'];
      final numberOfSets = p1Sets.length;
      column++;
      timeline
          .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
          .value = p1Sets.last['game'];

      final p2Sets = score['p2'];
      column++;
      timeline
          .cell(CellIndex.indexByString('${String.fromCharCode(column)}$row'))
          .value = p2Sets.last['game'];

      column++;
      for (var i = 0; i < numberOfSets; i++) {
        timeline
            .cell(CellIndex.indexByString(
                '${String.fromCharCode(column + (2 * i))}$row'))
            .value = p1Sets[i]['set'];
        timeline
            .cell(CellIndex.indexByString(
                '${String.fromCharCode(column + (2 * i) + 1)}$row'))
            .value = p2Sets[i]['set'];
      }
    }
  }

  statsSheet(sheet: excel['Stats']);

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