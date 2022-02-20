import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';
import '../logic/stats.dart';
import '../logic/score.dart';
import '../logic/date_time.dart';

void statsSheet(
    {required spreadsheet, required Map stats, required Map match}) {
  final matchWinner = stats['p1']['results'][0]['points-won'] >=
          stats['p2']['results'][0]['points-won']
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
      stats['p1']['results'][i]['points-won'],
      stats['p2']['results'][i]['points-won']
    ]);
    sheet.appendRow([
      'Total won %',
      stats['p1']['results'][i]['points-won-%'],
      stats['p2']['results'][i]['points-won-%']
    ]);
    sheet.appendRow([
      'Winners',
      stats['p1']['results'][i]['winners'],
      stats['p2']['results'][i]['winners']
    ]);
    sheet.appendRow([
      'Service points played',
      stats['p1']['results'][i]['service-points-played'],
      stats['p2']['results'][i]['service-points-played']
    ]);
    sheet.appendRow([
      'Service points won',
      stats['p1']['results'][i]['service-points-won'],
      stats['p2']['results'][i]['service-points-won']
    ]);
    sheet.appendRow([
      'Service points won %',
      stats['p1']['results'][i]['service-points-won-%'],
      stats['p2']['results'][i]['service-points-won-%']
    ]);
    sheet.appendRow([
      'Return points played',
      stats['p1']['results'][i]['return-points-played'],
      stats['p2']['results'][i]['return-points-played']
    ]);
    sheet.appendRow([
      'Return points won',
      stats['p1']['results'][i]['return-points-won'],
      stats['p2']['results'][i]['return-points-won']
    ]);
    sheet.appendRow([
      'Return points won %',
      stats['p1']['results'][i]['return-points-won-%'],
      stats['p2']['results'][i]['return-points-won-%']
    ]);
    sheet.appendRow([
      'Net points played',
      stats['p1']['results'][i]['net-points-played'],
      stats['p2']['results'][i]['net-points-played']
    ]);
    sheet.appendRow([
      'Net points won',
      stats['p1']['results'][i]['net-points-won'],
      stats['p2']['results'][i]['net-points-won']
    ]);
    sheet.appendRow([
      'Net points won %',
      stats['p1']['results'][i]['net-points-won-%'],
      stats['p2']['results'][i]['net-points-won-%']
    ]);

    sheet.appendRow(['']);
    sheet.appendRow(['Serve Stats', stats['p1']['name'], stats['p2']['name']]);
    sheet.appendRow([
      'Aces',
      stats['p1']['results'][i]['aces'],
      stats['p2']['results'][i]['aces']
    ]);
    sheet.appendRow([
      'Aces T',
      stats['p1']['results'][i]['aces-T'],
      stats['p2']['results'][i]['aces-T']
    ]);
    sheet.appendRow([
      'Aces body',
      stats['p1']['results'][i]['aces-body'],
      stats['p2']['results'][i]['aces-body']
    ]);
    sheet.appendRow([
      'Aces out wide',
      stats['p1']['results'][i]['aces-out-wide'],
      stats['p2']['results'][i]['aces-out-wide']
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
      '1st serve points won',
      stats['p1']['results'][i]['1st-serve-won'],
      stats['p2']['results'][i]['1st-serve-won']
    ]);
    sheet.appendRow([
      '1st serve points won %',
      stats['p1']['results'][i]['1st-serve-won-%'],
      stats['p2']['results'][i]['1st-serve-won-%']
    ]);
    sheet.appendRow([
      '2nd serve points played',
      stats['p1']['results'][i]['2nd-serve-played'],
      stats['p2']['results'][i]['2nd-serve-played']
    ]);
    sheet.appendRow([
      '2nd serve points won',
      stats['p1']['results'][i]['2nd-serve-won'],
      stats['p2']['results'][i]['2nd-serve-won']
    ]);
    sheet.appendRow([
      '2nd serve points won %',
      stats['p1']['results'][i]['2nd-serve-won-%'],
      stats['p2']['results'][i]['2nd-serve-won-%']
    ]);
    sheet.appendRow([
      'Game points played',
      stats['p1']['results'][i]['game-points-played'],
      stats['p2']['results'][i]['game-points-played']
    ]);
    sheet.appendRow([
      'Game points won',
      stats['p1']['results'][i]['game-points-won'],
      stats['p2']['results'][i]['game-points-won']
    ]);
    sheet.appendRow([
      'Game points won %',
      stats['p1']['results'][i]['game-points-won-%'],
      stats['p2']['results'][i]['game-points-won-%']
    ]);
    sheet.appendRow([
      'Break points played',
      stats['p1']['results'][i]['break-points-played'],
      stats['p2']['results'][i]['break-points-played']
    ]);
    sheet.appendRow([
      'Break points won',
      stats['p1']['results'][i]['break-points-won'],
      stats['p2']['results'][i]['break-points-won']
    ]);
    sheet.appendRow([
      'Break points won %',
      stats['p1']['results'][i]['break-points-won-%'],
      stats['p2']['results'][i]['break-points-won-%']
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
      stats['p1']['results'][i]['forehand-won'],
      stats['p2']['results'][i]['forehand-won']
    ]);
    sheet.appendRow([
      'Winners %',
      stats['p1']['results'][i]['forehand-won-%'],
      stats['p2']['results'][i]['forehand-won-%']
    ]);
    sheet.appendRow([
      'Winners down the line',
      stats['p1']['results'][i]['forehand-won-down-the-line'],
      stats['p2']['results'][i]['forehand-won-down-the-line']
    ]);
    sheet.appendRow([
      'Winners middle',
      stats['p1']['results'][i]['forehand-won-middle'],
      stats['p2']['results'][i]['forehand-won-middle']
    ]);
    sheet.appendRow([
      'Winners cross court',
      stats['p1']['results'][i]['forehand-won-cross-court'],
      stats['p2']['results'][i]['forehand-won-cross-court']
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
      'Into the net down the line',
      stats['p1']['results'][i]['forehand-net-down-the-line'],
      stats['p2']['results'][i]['forehand-net-down-the-line']
    ]);
    sheet.appendRow([
      'Into the net middle',
      stats['p1']['results'][i]['forehand-net-middle'],
      stats['p2']['results'][i]['forehand-net-middle']
    ]);
    sheet.appendRow([
      'Into the net cross court',
      stats['p1']['results'][i]['forehand-net-cross-court'],
      stats['p2']['results'][i]['forehand-net-cross-court']
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
    sheet.appendRow([
      'Out down the line',
      stats['p1']['results'][i]['forehand-out-down-the-line'],
      stats['p2']['results'][i]['forehand-out-down-the-line']
    ]);
    sheet.appendRow([
      'Out middle',
      stats['p1']['results'][i]['forehand-out-middle'],
      stats['p2']['results'][i]['forehand-out-middle']
    ]);
    sheet.appendRow([
      'Out cross court',
      stats['p1']['results'][i]['forehand-out-cross-court'],
      stats['p2']['results'][i]['forehand-out-cross-court']
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
      stats['p1']['results'][i]['backhand-won'],
      stats['p2']['results'][i]['backhand-won']
    ]);
    sheet.appendRow([
      'Winners %',
      stats['p1']['results'][i]['backhand-won-%'],
      stats['p2']['results'][i]['backhand-won-%']
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
      stats['p1']['results'][i]['volley-won'],
      stats['p2']['results'][i]['volley-won']
    ]);
    sheet.appendRow([
      'Winners %',
      stats['p1']['results'][i]['volley-won-%'],
      stats['p2']['results'][i]['volley-won-%']
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
      stats['p1']['results'][i]['smash-won'],
      stats['p2']['results'][i]['smash-won']
    ]);
    sheet.appendRow([
      'Winners %',
      stats['p1']['results'][i]['smash-won-%'],
      stats['p2']['results'][i]['smash-won-%']
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
