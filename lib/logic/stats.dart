import 'score.dart';

void updatePercentages(report, currentSet, prefix) {
  if (report['p1']['results'][0][prefix + '-played'] > 0)
    report['p1']['results'][0][prefix + '-win-%'] = (100 *
            (report['p1']['results'][0][prefix + '-win'] /
                report['p1']['results'][0][prefix + '-played']))
        .round();
  if (report['p1']['results'][currentSet][prefix + '-played'] > 0)
    report['p1']['results'][currentSet][prefix + '-win-%'] = (100 *
            (report['p1']['results'][currentSet][prefix + '-win'] /
                report['p1']['results'][currentSet][prefix + '-played']))
        .round();
  if (report['p2']['results'][currentSet][prefix + '-played'] > 0)
    report['p2']['results'][0][prefix + '-win-%'] = (100 *
            (report['p2']['results'][0][prefix + '-win'] /
                report['p2']['results'][0][prefix + '-played']))
        .round();
  if (report['p2']['results'][currentSet][prefix + '-played'] > 0)
    report['p2']['results'][currentSet][prefix + '-win-%'] = (100 *
            (report['p2']['results'][currentSet][prefix + '-win'] /
                report['p2']['results'][currentSet][prefix + '-played']))
        .round();
}

Map matchStats({required Map match}) {
  final events = match['events'];
  var lastScore = events.last['event'] == 'FinalScore'
      ? events[match['events'].length - 2]
      : events.last;
  Map<String, dynamic> report = {
    'score': formatScore(match, lastScore, lastScore['server']),
    'match-duration': [],
    'match-time': [],
    'scores': [],
    'p1': {'name': match['p1'], 'results': []},
    'p2': {'name': match['p2'], 'results': []}
  };

  Map statsBlueprint = {
    'points-played': 0,
    'points-win': 0,
    'points-win-%': 0.0,
    'aces': 0,
    'double-faults': 0,
    '1st-serve-played': 0,
    '1st-serve-win': 0,
    '1st-serve-win-%': 0.0,
    '2nd-serve-played': 0,
    '2nd-serve-win': 0,
    '2nd-serve-win-%': 0.0,
    'break-points-played': 0,
    'break-points-win': 0,
    'break-points-win-%': 0.0,
    'game-points-played': 0,
    'game-points-win': 0,
    'game-points-win-%': 0.0,
  };
  for (var i = 0; i <= lastScore['p1'].length; i++) {
    report['match-time']
        .add({'start': match['createdAt'], 'end': match['createdAt']});
    report['p1']['results'].add({...statsBlueprint});
    report['p2']['results'].add({...statsBlueprint});
    report['scores'].add({});
  }
  report['scores'][0] = lastScore;

  var fault = false;
  for (var i = 0; i < events.length; i++) {
    final event = events[i];
    if (event['event'] == 'Rally') {
      final scoreBefore = events[i - 1];
      final scoreAfter = events[i + 1];
      final lastHitBy = event['lastHitBy'];
      final server = event['server'];
      final receiver = server == 'p1' ? 'p2' : 'p1';
      final winner = event['winner'];
      final shot = event['shot'];
      final depth = event['depth'];
      final currentSet = scoreBefore['p1'].length;

      report['scores'][currentSet] = scoreAfter;

      if (report['match-time'][currentSet]['start'] == match['createdAt']) {
        report['match-time'][currentSet]['start'] = event['createdAt'];
      }
      report['match-time'][currentSet]['end'] = event['createdAt'];

      if (event['winner'] == null) {
        fault = true;
      } else {
        report['p1']['results'][0]['points-played']++;
        report['p1']['results'][currentSet]['points-played']++;
        report['p2']['results'][0]['points-played']++;
        report['p2']['results'][currentSet]['points-played']++;

        report[winner]['results'][0]['points-win']++;
        report[winner]['results'][currentSet]['points-win']++;
        updatePercentages(report, currentSet, 'points');

        if (lastHitBy == server &&
            winner == lastHitBy &&
            shot == 'SV' &&
            depth == 'I') {
          report[lastHitBy]['results'][0]['aces']++;
          report[lastHitBy]['results'][currentSet]['aces']++;
        }
        if (lastHitBy == server &&
            winner != lastHitBy &&
            shot == 'SV' &&
            depth != 'I') {
          report[lastHitBy]['results'][0]['double-faults']++;
          report[lastHitBy]['results'][currentSet]['double-faults']++;
        }

        if (fault) {
          report[server]['results'][0]['2nd-serve-played']++;
          report[server]['results'][currentSet]['2nd-serve-played']++;
          if (server == winner) {
            report[server]['results'][0]['2nd-serve-win']++;
            report[server]['results'][currentSet]['2nd-serve-win']++;
          }
          updatePercentages(report, currentSet, '2nd-serve');
        } else {
          report[server]['results'][0]['1st-serve-played']++;
          report[server]['results'][currentSet]['1st-serve-played']++;
          if (server == winner) {
            report[server]['results'][0]['1st-serve-win']++;
            report[server]['results'][currentSet]['1st-serve-win']++;
          }
          updatePercentages(report, currentSet, '1st-serve');
        }
        fault = false;

        if ((scoreBefore[receiver][currentSet - 1]['game'] == '40' &&
                !['40', 'Ad']
                    .contains(scoreBefore[server][currentSet - 1]['game'])) ||
            (scoreBefore[receiver][currentSet - 1]['game'] == 'Ad')) {
          report[receiver]['results'][0]['break-points-played']++;
          report[receiver]['results'][currentSet]['break-points-played']++;
          report[receiver]['results'][0]['game-points-played']++;
          report[receiver]['results'][currentSet]['game-points-played']++;
          if (receiver == winner) {
            report[receiver]['results'][0]['break-points-win']++;
            report[receiver]['results'][currentSet]['break-points-win']++;
            report[receiver]['results'][0]['game-points-win']++;
            report[receiver]['results'][currentSet]['game-points-win']++;
            updatePercentages(report, currentSet, 'break-points');
            updatePercentages(report, currentSet, 'game-points');
          }
        }

        if ((scoreBefore[server][currentSet - 1]['game'] == '40' &&
                !['40', 'Ad']
                    .contains(scoreBefore[receiver][currentSet - 1]['game'])) ||
            (scoreBefore[server][currentSet - 1]['game'] == 'Ad')) {
          report[server]['results'][0]['game-points-played']++;
          report[server]['results'][currentSet]['game-points-played']++;
          if (server == winner) {
            report[server]['results'][0]['game-points-win']++;
            report[server]['results'][currentSet]['game-points-win']++;
            updatePercentages(report, currentSet, 'game-points');
          }
        }
      }
    }
  }

  for (var i = 0; i <= lastScore['p1'].length; i++) {
    final duration = report['match-time'][i]['end']
        .difference(report['match-time'][i]['start']);
    report['match-duration'].add(duration);
  }
  report['match-duration'][0] =
      report['match-duration'].reduce((value, element) => value + element);

  return report;
}

Map decidingPoints({required List<Map> events}) {
  var report = <String, dynamic>{
    'points': 0,
    'p1': {
      'points': 0,
      'service': {
        'points': 0,
        'faults': 0,
        'double-fault': 0,
        'ace': 0,
        'shots': 0,
        'into-the-net': 0,
        'out': 0,
        'in': 0
      },
      'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
      'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
      'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
      'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
    },
    'p2': {
      'points': 0,
      'service': {
        'points': 0,
        'faults': 0,
        'double-fault': 0,
        'ace': 0,
        'shots': 0,
        'into-the-net': 0,
        'out': 0,
        'in': 0
      },
      'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
      'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
      'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
      'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
    }
  };
  var fault = false;
  for (var i = 0; i < events.length; i++) {
    final event = events[i];
    if (event['event'] == 'Rally') {
      final lastHitBy = event['lastHitBy'];
      final server = event['server'];
      final winner = event['winner'];
      final shot = event['shot'];
      final depth = event['depth'];

      if (shot == 'SV') {
        if (winner == null) {
          report[lastHitBy]['service']['faults']++;
          fault = true;
        } else {
          report['points']++;
          report[lastHitBy]['points']++;
          report[lastHitBy]['service']['points']++;
          if (fault && server != winner)
            report[lastHitBy]['service']['double-fault']++;
          fault = false;
        }
        report[lastHitBy]['service']['shots']++;
        if (depth == 'O') report[lastHitBy]['service']['out']++;
        if (depth == 'N') report[lastHitBy]['service']['into-the-net']++;
        if (depth == 'I') {
          report[lastHitBy]['service']['ace']++;
          report[lastHitBy]['service']['in']++;
        }
      } else if (shot == 'FH') {
        report['points']++;
        report[lastHitBy]['points']++;
        report[lastHitBy]['forehand']['points']++;
        if (depth == 'O') report[lastHitBy]['forehand']['out']++;
        if (depth == 'N') report[lastHitBy]['forehand']['into-the-net']++;
        if (depth == 'I') report[lastHitBy]['forehand']['winner']++;
      } else if (shot == 'BH') {
        report['points']++;
        report[lastHitBy]['points']++;
        report[lastHitBy]['backhand']['points']++;
        if (depth == 'O') report[lastHitBy]['backhand']['out']++;
        if (depth == 'N') report[lastHitBy]['backhand']['into-the-net']++;
        if (depth == 'I') report[lastHitBy]['backhand']['winner']++;
      } else if (shot == 'V') {
        report['points']++;
        report[lastHitBy]['points']++;
        report[lastHitBy]['volley']['points']++;
        if (depth == 'O') report[lastHitBy]['volley']['out']++;
        if (depth == 'N') report[lastHitBy]['volley']['into-the-net']++;
        if (depth == 'I') report[lastHitBy]['volley']['winner']++;
      } else if (shot == 'SM') {
        report['points']++;
        report[lastHitBy]['points']++;
        report[lastHitBy]['smash']['points']++;
        if (depth == 'O') report[lastHitBy]['smash']['out']++;
        if (depth == 'N') report[lastHitBy]['smash']['into-the-net']++;
        if (depth == 'I') report[lastHitBy]['smash']['winner']++;
      }
    }
  }
  return report;
}

Map wonLost({required List<Map> events}) {
  var report = <String, dynamic>{
    'p1': {
      'match': {'played': 0, 'won': 0, 'lost': 0},
      'serving': {'played': 0, 'won': 0, 'lost': 0}
    },
    'p2': {
      'match': {'played': 0, 'won': 0, 'lost': 0},
      'serving': {'played': 0, 'won': 0, 'lost': 0}
    }
  };

  for (var i = 0; i < events.length; i++) {
    final event = events[i];
    if (event['event'] == 'Rally') {
      final winner = event['winner'];
      if (winner != null) {
        final server = event['server'];
        report[server]['serving']['played']++;
        if (winner == server) {
          report[server]['serving']['won']++;
        } else {
          report[server]['serving']['lost']++;
        }

        report['p1']['match']['played']++;
        report['p2']['match']['played']++;
        if (winner == 'p1') {
          report['p1']['match']['won']++;
          report['p2']['match']['lost']++;
        } else {
          report['p2']['match']['won']++;
          report['p1']['match']['lost']++;
        }
      }
    }
  }
  return report;
}
