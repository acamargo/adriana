import 'package:flutter/material.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';
import 'package:adriana/accidental/storage/matches.dart';
import 'package:adriana/essential/stats.dart';
import 'package:adriana/essential/score.dart';
import 'package:adriana/accidental/logic/date_time.dart';

void statsSheet(
    {required spreadsheet, required Map stats, required Map match}) {
  final matchWinner = stats['p1']['results'][0]['points-won'] >=
          stats['p2']['results'][0]['points-won']
      ? 'p1'
      : 'p2';
  for (var i = 0; i < stats['p1']['results'].length; i++) {
    if (stats['scores'][i].isEmpty) continue;

    final title = (i == 0) ? 'Overall' : 'Set $i';
    var sheet = spreadsheet[title];
    sheet.appendRow([
      TextCellValue('Players'),
      TextCellValue('${match['p1']} vs ${match['p2']}')
    ]);
    sheet.appendRow(
        [TextCellValue('Court surface'), TextCellValue(match['surface'])]);
    sheet.appendRow([TextCellValue('Venue'), TextCellValue(match['venue'])]);
    sheet.appendRow([
      TextCellValue('Date'),
      TextCellValue(formatStatsWeekday(match['createdAt'])),
      TextCellValue(match['createdAt'].toString().split('.').first)
    ]);
    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([TextCellValue(title)]);
    sheet.appendRow([
      TextCellValue('Score'),
      TextCellValue((i == 0)
          ? formatStatsScore(match, match['events'].last, matchWinner)
          : formatStatsSet(match['p1'], match['p2'], stats['scores'][i]))
    ]);
    sheet.appendRow([
      TextCellValue('Duration'),
      TextCellValue(stats['match-duration'][i].toString().split('.').first)
    ]);
    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([
      TextCellValue('Point Stats'),
      TextCellValue(stats['p1']['name']),
      TextCellValue(stats['p2']['name'])
    ]);
    sheet.appendRow([
      TextCellValue('Played'),
      IntCellValue(stats['p1']['results'][i]['points-played']),
      IntCellValue(stats['p2']['results'][i]['points-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Total won'),
      IntCellValue(stats['p1']['results'][i]['points-won']),
      IntCellValue(stats['p2']['results'][i]['points-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Total won %'),
      IntCellValue(stats['p1']['results'][i]['points-won-%']),
      IntCellValue(stats['p2']['results'][i]['points-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners'),
      IntCellValue(stats['p1']['results'][i]['winners']),
      IntCellValue(stats['p2']['results'][i]['winners'])
    ]);
    sheet.appendRow([
      TextCellValue('Service points played'),
      IntCellValue(stats['p1']['results'][i]['service-points-played']),
      IntCellValue(stats['p2']['results'][i]['service-points-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Service points won'),
      IntCellValue(stats['p1']['results'][i]['service-points-won']),
      IntCellValue(stats['p2']['results'][i]['service-points-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Service points won %'),
      IntCellValue(stats['p1']['results'][i]['service-points-won-%']),
      IntCellValue(stats['p2']['results'][i]['service-points-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Receiver points played'),
      IntCellValue(stats['p1']['results'][i]['return-points-played']),
      IntCellValue(stats['p2']['results'][i]['return-points-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Receiver points won'),
      IntCellValue(stats['p1']['results'][i]['return-points-won']),
      IntCellValue(stats['p2']['results'][i]['return-points-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Receiver points won %'),
      IntCellValue(stats['p1']['results'][i]['return-points-won-%']),
      IntCellValue(stats['p2']['results'][i]['return-points-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Net points played'),
      IntCellValue(stats['p1']['results'][i]['net-points-played']),
      IntCellValue(stats['p2']['results'][i]['net-points-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Net points won'),
      IntCellValue(stats['p1']['results'][i]['net-points-won']),
      IntCellValue(stats['p2']['results'][i]['net-points-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Net points won %'),
      IntCellValue(stats['p1']['results'][i]['net-points-won-%']),
      IntCellValue(stats['p2']['results'][i]['net-points-won-%'])
    ]);

    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([
      TextCellValue('Serve Stats'),
      TextCellValue(stats['p1']['name']),
      TextCellValue(stats['p2']['name'])
    ]);
    sheet.appendRow([
      TextCellValue('Aces'),
      IntCellValue(stats['p1']['results'][i]['aces']),
      IntCellValue(stats['p2']['results'][i]['aces'])
    ]);
    sheet.appendRow([
      TextCellValue('Aces T'),
      IntCellValue(stats['p1']['results'][i]['aces-T']),
      IntCellValue(stats['p2']['results'][i]['aces-T'])
    ]);
    sheet.appendRow([
      TextCellValue('Aces body'),
      IntCellValue(stats['p1']['results'][i]['aces-body']),
      IntCellValue(stats['p2']['results'][i]['aces-body'])
    ]);
    sheet.appendRow([
      TextCellValue('Aces out wide'),
      IntCellValue(stats['p1']['results'][i]['aces-out-wide']),
      IntCellValue(stats['p2']['results'][i]['aces-out-wide'])
    ]);
    sheet.appendRow([
      TextCellValue('Double faults'),
      IntCellValue(stats['p1']['results'][i]['double-faults']),
      IntCellValue(stats['p2']['results'][i]['double-faults'])
    ]);
    sheet.appendRow([
      TextCellValue('1st serve in'),
      IntCellValue(stats['p1']['results'][i]['1st-serve-played']),
      IntCellValue(stats['p2']['results'][i]['1st-serve-played'])
    ]);
    sheet.appendRow([
      TextCellValue('1st serve points won'),
      IntCellValue(stats['p1']['results'][i]['1st-serve-won']),
      IntCellValue(stats['p2']['results'][i]['1st-serve-won'])
    ]);
    sheet.appendRow([
      TextCellValue('1st serve points won %'),
      IntCellValue(stats['p1']['results'][i]['1st-serve-won-%']),
      IntCellValue(stats['p2']['results'][i]['1st-serve-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('2nd serve in'),
      IntCellValue(stats['p1']['results'][i]['2nd-serve-played']),
      IntCellValue(stats['p2']['results'][i]['2nd-serve-played'])
    ]);
    sheet.appendRow([
      TextCellValue('2nd serve points won'),
      IntCellValue(stats['p1']['results'][i]['2nd-serve-won']),
      IntCellValue(stats['p2']['results'][i]['2nd-serve-won'])
    ]);
    sheet.appendRow([
      TextCellValue('2nd serve points won %'),
      IntCellValue(stats['p1']['results'][i]['2nd-serve-won-%']),
      IntCellValue(stats['p2']['results'][i]['2nd-serve-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Game points played'),
      IntCellValue(stats['p1']['results'][i]['game-points-played']),
      IntCellValue(stats['p2']['results'][i]['game-points-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Game points won'),
      IntCellValue(stats['p1']['results'][i]['game-points-won']),
      IntCellValue(stats['p2']['results'][i]['game-points-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Game points won %'),
      IntCellValue(stats['p1']['results'][i]['game-points-won-%']),
      IntCellValue(stats['p2']['results'][i]['game-points-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Break points played'),
      IntCellValue(stats['p1']['results'][i]['break-points-played']),
      IntCellValue(stats['p2']['results'][i]['break-points-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Break points won'),
      IntCellValue(stats['p1']['results'][i]['break-points-won']),
      IntCellValue(stats['p2']['results'][i]['break-points-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Break points won %'),
      IntCellValue(stats['p1']['results'][i]['break-points-won-%']),
      IntCellValue(stats['p2']['results'][i]['break-points-won-%'])
    ]);

    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([
      TextCellValue('Forehand Stats'),
      TextCellValue(stats['p1']['name']),
      TextCellValue(stats['p2']['name'])
    ]);
    sheet.appendRow([
      TextCellValue('Total points decided with'),
      IntCellValue(stats['p1']['results'][i]['forehand-played']),
      IntCellValue(stats['p2']['results'][i]['forehand-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners'),
      IntCellValue(stats['p1']['results'][i]['forehand-won']),
      IntCellValue(stats['p2']['results'][i]['forehand-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners %'),
      IntCellValue(stats['p1']['results'][i]['forehand-won-%']),
      IntCellValue(stats['p2']['results'][i]['forehand-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners down the line'),
      IntCellValue(stats['p1']['results'][i]['forehand-won-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['forehand-won-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners middle'),
      IntCellValue(stats['p1']['results'][i]['forehand-won-middle']),
      IntCellValue(stats['p2']['results'][i]['forehand-won-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners cross court'),
      IntCellValue(stats['p1']['results'][i]['forehand-won-cross-court']),
      IntCellValue(stats['p2']['results'][i]['forehand-won-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net'),
      IntCellValue(stats['p1']['results'][i]['forehand-net']),
      IntCellValue(stats['p2']['results'][i]['forehand-net'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net %'),
      IntCellValue(stats['p1']['results'][i]['forehand-net-%']),
      IntCellValue(stats['p2']['results'][i]['forehand-net-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net down the line'),
      IntCellValue(stats['p1']['results'][i]['forehand-net-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['forehand-net-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net middle'),
      IntCellValue(stats['p1']['results'][i]['forehand-net-middle']),
      IntCellValue(stats['p2']['results'][i]['forehand-net-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net cross court'),
      IntCellValue(stats['p1']['results'][i]['forehand-net-cross-court']),
      IntCellValue(stats['p2']['results'][i]['forehand-net-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Out'),
      IntCellValue(stats['p1']['results'][i]['forehand-out']),
      IntCellValue(stats['p2']['results'][i]['forehand-out'])
    ]);
    sheet.appendRow([
      TextCellValue('Out %'),
      IntCellValue(stats['p1']['results'][i]['forehand-out-%']),
      IntCellValue(stats['p2']['results'][i]['forehand-out-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Out down the line'),
      IntCellValue(stats['p1']['results'][i]['forehand-out-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['forehand-out-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Out middle'),
      IntCellValue(stats['p1']['results'][i]['forehand-out-middle']),
      IntCellValue(stats['p2']['results'][i]['forehand-out-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Out cross court'),
      IntCellValue(stats['p1']['results'][i]['forehand-out-cross-court']),
      IntCellValue(stats['p2']['results'][i]['forehand-out-cross-court'])
    ]);

    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([
      TextCellValue('Backhand Stats'),
      TextCellValue(stats['p1']['name']),
      TextCellValue(stats['p2']['name'])
    ]);
    sheet.appendRow([
      TextCellValue('Total points decided with'),
      IntCellValue(stats['p1']['results'][i]['backhand-played']),
      IntCellValue(stats['p2']['results'][i]['backhand-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners'),
      IntCellValue(stats['p1']['results'][i]['backhand-won']),
      IntCellValue(stats['p2']['results'][i]['backhand-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners %'),
      IntCellValue(stats['p1']['results'][i]['backhand-won-%']),
      IntCellValue(stats['p2']['results'][i]['backhand-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners down the line'),
      IntCellValue(stats['p1']['results'][i]['backhand-won-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['backhand-won-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners middle'),
      IntCellValue(stats['p1']['results'][i]['backhand-won-middle']),
      IntCellValue(stats['p2']['results'][i]['backhand-won-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners cross court'),
      IntCellValue(stats['p1']['results'][i]['backhand-won-cross-court']),
      IntCellValue(stats['p2']['results'][i]['backhand-won-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net'),
      IntCellValue(stats['p1']['results'][i]['backhand-net']),
      IntCellValue(stats['p2']['results'][i]['backhand-net'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net %'),
      IntCellValue(stats['p1']['results'][i]['backhand-net-%']),
      IntCellValue(stats['p2']['results'][i]['backhand-net-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net down the line'),
      IntCellValue(stats['p1']['results'][i]['backhand-net-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['backhand-net-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net middle'),
      IntCellValue(stats['p1']['results'][i]['backhand-net-middle']),
      IntCellValue(stats['p2']['results'][i]['backhand-net-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net cross court'),
      IntCellValue(stats['p1']['results'][i]['backhand-net-cross-court']),
      IntCellValue(stats['p2']['results'][i]['backhand-net-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Out'),
      IntCellValue(stats['p1']['results'][i]['backhand-out']),
      IntCellValue(stats['p2']['results'][i]['backhand-out'])
    ]);
    sheet.appendRow([
      TextCellValue('Out %'),
      IntCellValue(stats['p1']['results'][i]['backhand-out-%']),
      IntCellValue(stats['p2']['results'][i]['backhand-out-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Out down the line'),
      IntCellValue(stats['p1']['results'][i]['backhand-out-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['backhand-out-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Out middle'),
      IntCellValue(stats['p1']['results'][i]['backhand-out-middle']),
      IntCellValue(stats['p2']['results'][i]['backhand-out-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Out cross court'),
      IntCellValue(stats['p1']['results'][i]['backhand-out-cross-court']),
      IntCellValue(stats['p2']['results'][i]['backhand-out-cross-court'])
    ]);

    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([
      TextCellValue('Volley Stats'),
      TextCellValue(stats['p1']['name']),
      TextCellValue(stats['p2']['name'])
    ]);
    sheet.appendRow([
      TextCellValue('Total points decided with'),
      IntCellValue(stats['p1']['results'][i]['volley-played']),
      IntCellValue(stats['p2']['results'][i]['volley-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners'),
      IntCellValue(stats['p1']['results'][i]['volley-won']),
      IntCellValue(stats['p2']['results'][i]['volley-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners %'),
      IntCellValue(stats['p1']['results'][i]['volley-won-%']),
      IntCellValue(stats['p2']['results'][i]['volley-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners down the line'),
      IntCellValue(stats['p1']['results'][i]['volley-won-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['volley-won-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners middle'),
      IntCellValue(stats['p1']['results'][i]['volley-won-middle']),
      IntCellValue(stats['p2']['results'][i]['volley-won-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners cross court'),
      IntCellValue(stats['p1']['results'][i]['volley-won-cross-court']),
      IntCellValue(stats['p2']['results'][i]['volley-won-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net'),
      IntCellValue(stats['p1']['results'][i]['volley-net']),
      IntCellValue(stats['p2']['results'][i]['volley-net'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net %'),
      IntCellValue(stats['p1']['results'][i]['volley-net-%']),
      IntCellValue(stats['p2']['results'][i]['volley-net-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net down the line'),
      IntCellValue(stats['p1']['results'][i]['volley-net-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['volley-net-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net middle'),
      IntCellValue(stats['p1']['results'][i]['volley-net-middle']),
      IntCellValue(stats['p2']['results'][i]['volley-net-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net cross court'),
      IntCellValue(stats['p1']['results'][i]['volley-net-cross-court']),
      IntCellValue(stats['p2']['results'][i]['volley-net-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Out'),
      IntCellValue(stats['p1']['results'][i]['volley-out']),
      IntCellValue(stats['p2']['results'][i]['volley-out'])
    ]);
    sheet.appendRow([
      TextCellValue('Out %'),
      IntCellValue(stats['p1']['results'][i]['volley-out-%']),
      IntCellValue(stats['p2']['results'][i]['volley-out-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Out down the line'),
      IntCellValue(stats['p1']['results'][i]['volley-out-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['volley-out-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Out middle'),
      IntCellValue(stats['p1']['results'][i]['volley-out-middle']),
      IntCellValue(stats['p2']['results'][i]['volley-out-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Out cross court'),
      IntCellValue(stats['p1']['results'][i]['volley-out-cross-court']),
      IntCellValue(stats['p2']['results'][i]['volley-out-cross-court'])
    ]);

    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([
      TextCellValue('Smash Stats'),
      TextCellValue(stats['p1']['name']),
      TextCellValue(stats['p2']['name'])
    ]);
    sheet.appendRow([
      TextCellValue('Total points decided with'),
      IntCellValue(stats['p1']['results'][i]['smash-played']),
      IntCellValue(stats['p2']['results'][i]['smash-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners'),
      IntCellValue(stats['p1']['results'][i]['smash-won']),
      IntCellValue(stats['p2']['results'][i]['smash-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners %'),
      IntCellValue(stats['p1']['results'][i]['smash-won-%']),
      IntCellValue(stats['p2']['results'][i]['smash-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners down the line'),
      IntCellValue(stats['p1']['results'][i]['smash-won-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['smash-won-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners middle'),
      IntCellValue(stats['p1']['results'][i]['smash-won-middle']),
      IntCellValue(stats['p2']['results'][i]['smash-won-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners cross court'),
      IntCellValue(stats['p1']['results'][i]['smash-won-cross-court']),
      IntCellValue(stats['p2']['results'][i]['smash-won-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net'),
      IntCellValue(stats['p1']['results'][i]['smash-net']),
      IntCellValue(stats['p2']['results'][i]['smash-net'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net %'),
      IntCellValue(stats['p1']['results'][i]['smash-net-%']),
      IntCellValue(stats['p2']['results'][i]['smash-net-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net down the line'),
      IntCellValue(stats['p1']['results'][i]['smash-net-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['smash-net-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net middle'),
      IntCellValue(stats['p1']['results'][i]['smash-net-middle']),
      IntCellValue(stats['p2']['results'][i]['smash-net-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net cross court'),
      IntCellValue(stats['p1']['results'][i]['smash-net-cross-court']),
      IntCellValue(stats['p2']['results'][i]['smash-net-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Out'),
      IntCellValue(stats['p1']['results'][i]['smash-out']),
      IntCellValue(stats['p2']['results'][i]['smash-out'])
    ]);
    sheet.appendRow([
      TextCellValue('Out %'),
      IntCellValue(stats['p1']['results'][i]['smash-out-%']),
      IntCellValue(stats['p2']['results'][i]['smash-out-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Out down the line'),
      IntCellValue(stats['p1']['results'][i]['smash-out-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['smash-out-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Out middle'),
      IntCellValue(stats['p1']['results'][i]['smash-out-middle']),
      IntCellValue(stats['p2']['results'][i]['smash-out-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Out cross court'),
      IntCellValue(stats['p1']['results'][i]['smash-out-cross-court']),
      IntCellValue(stats['p2']['results'][i]['smash-out-cross-court'])
    ]);

    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow([
      TextCellValue('Drop shot Stats'),
      TextCellValue(stats['p1']['name']),
      TextCellValue(stats['p2']['name'])
    ]);
    sheet.appendRow([
      TextCellValue('Total points decided with'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-played']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-played'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-won']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-won'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners %'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-won-%']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-won-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners down the line'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-won-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-won-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners middle'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-won-middle']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-won-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Winners cross court'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-won-cross-court']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-won-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-net']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-net'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net %'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-net-%']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-net-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net down the line'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-net-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-net-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net middle'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-net-middle']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-net-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Into the net cross court'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-net-cross-court']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-net-cross-court'])
    ]);
    sheet.appendRow([
      TextCellValue('Out'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-out']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-out'])
    ]);
    sheet.appendRow([
      TextCellValue('Out %'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-out-%']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-out-%'])
    ]);
    sheet.appendRow([
      TextCellValue('Out down the line'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-out-down-the-line']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-out-down-the-line'])
    ]);
    sheet.appendRow([
      TextCellValue('Out middle'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-out-middle']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-out-middle'])
    ]);
    sheet.appendRow([
      TextCellValue('Out cross court'),
      IntCellValue(stats['p1']['results'][i]['drop-shot-out-cross-court']),
      IntCellValue(stats['p2']['results'][i]['drop-shot-out-cross-court'])
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
    TextCellValue('Time'),
    TextCellValue('Point Number'),
    TextCellValue('Event'),
    TextCellValue('Server'),
    TextCellValue('Decider'),
    TextCellValue('Shot'),
    TextCellValue('Call'),
    TextCellValue('Winner'),
    TextCellValue('Points ${match['p1']}'),
    TextCellValue('Points ${match['p2']}')
  ];
  final numberOfSets = match['events'].last['p1'].length;
  for (var i = 0; i < numberOfSets; i++) {
    row.add(TextCellValue('Set ${i + 1} ${match['p1']}'));
    row.add(TextCellValue('Set ${i + 1} ${match['p2']}'));
  }
  sheet.appendRow(row);

  for (int index = 0; index < match['events'].length; index++) {
    final event = match['events'][index];
    var row = [
      TextCellValue(event['createdAt'].toIso8601String()),
      TextCellValue(event['pointNumber'].toString()),
      TextCellValue(event['event']),
    ];
    if (event['event'] == 'CoinToss') {
      row.addAll([TextCellValue(match[event['server']])]);
    } else if (event['event'] == 'Score' || event['event'] == 'FinalScore') {
      row.addAll([
        TextCellValue(''),
        TextCellValue(''),
        TextCellValue(''),
        TextCellValue(''),
        TextCellValue('')
      ]);
      final p1Sets = event['p1'];
      final numberOfSets = p1Sets.length;
      row.add(TextCellValue(p1Sets.last['game']));

      final p2Sets = event['p2'];
      row.add(TextCellValue(p2Sets.last['game']));

      for (var i = 0; i < numberOfSets; i++) {
        row.add(TextCellValue(p1Sets[i]['set'].toString()));
        row.add(TextCellValue(p2Sets[i]['set'].toString()));
      }
    } else if (event['event'] == 'Rally') {
      row.addAll([
        TextCellValue(match[event['server']]),
        TextCellValue(match[event['lastHitBy']]),
        TextCellValue(shots[event['shot']].toString()),
        TextCellValue((event['server'] == event['lastHitBy'] &&
                event['shot'] == 'SV' &&
                event['depth'] == 'I')
            ? 'Ace'
            : depths[event['depth']].toString()),
        TextCellValue(
            event['winner'] == null ? 'FAULT' : match[event['winner']])
      ]);
    }
    sheet.appendRow(row);
  }
}

Future<String> statsSpreadsheetFilename({required Map match}) async {
  var directory = await MatchesStorage().getExternalSdCardPath();
  final fileName = match['createdAt'].toIso8601String().replaceAll(':', '-');
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
