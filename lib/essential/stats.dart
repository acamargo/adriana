import 'score.dart';

void updatePercentages(report, currentSet, prefix) {
  if (report['p1']['results'][0][prefix + '-played'] > 0) {
    report['p1']['results'][0][prefix + '-won-%'] = (100 *
            (report['p1']['results'][0][prefix + '-won'] /
                report['p1']['results'][0][prefix + '-played']))
        .round();
    if (report['p1']['results'][0][prefix + '-out'] != null)
      report['p1']['results'][0][prefix + '-out-%'] = (100 *
              (report['p1']['results'][0][prefix + '-out'] /
                  report['p1']['results'][0][prefix + '-played']))
          .round();
    if (report['p1']['results'][0][prefix + '-net'] != null)
      report['p1']['results'][0][prefix + '-net-%'] = (100 *
              (report['p1']['results'][0][prefix + '-net'] /
                  report['p1']['results'][0][prefix + '-played']))
          .round();
  }
  if (report['p1']['results'][currentSet][prefix + '-played'] > 0) {
    report['p1']['results'][currentSet][prefix + '-won-%'] = (100 *
            (report['p1']['results'][currentSet][prefix + '-won'] /
                report['p1']['results'][currentSet][prefix + '-played']))
        .round();
    if (report['p1']['results'][currentSet][prefix + '-out'] != null)
      report['p1']['results'][currentSet][prefix + '-out-%'] = (100 *
              (report['p1']['results'][currentSet][prefix + '-out'] /
                  report['p1']['results'][currentSet][prefix + '-played']))
          .round();
    if (report['p1']['results'][currentSet][prefix + '-net'] != null)
      report['p1']['results'][currentSet][prefix + '-net-%'] = (100 *
              (report['p1']['results'][currentSet][prefix + '-net'] /
                  report['p1']['results'][currentSet][prefix + '-played']))
          .round();
  }
  if (report['p2']['results'][currentSet][prefix + '-played'] > 0) {
    report['p2']['results'][0][prefix + '-won-%'] = (100 *
            (report['p2']['results'][0][prefix + '-won'] /
                report['p2']['results'][0][prefix + '-played']))
        .round();
    if (report['p2']['results'][0][prefix + '-out'] != null)
      report['p2']['results'][0][prefix + '-out-%'] = (100 *
              (report['p2']['results'][0][prefix + '-out'] /
                  report['p2']['results'][0][prefix + '-played']))
          .round();
    if (report['p2']['results'][0][prefix + '-net'] != null)
      report['p2']['results'][0][prefix + '-net-%'] = (100 *
              (report['p2']['results'][0][prefix + '-net'] /
                  report['p2']['results'][0][prefix + '-played']))
          .round();
  }
  if (report['p2']['results'][currentSet][prefix + '-played'] > 0) {
    report['p2']['results'][currentSet][prefix + '-won-%'] = (100 *
            (report['p2']['results'][currentSet][prefix + '-won'] /
                report['p2']['results'][currentSet][prefix + '-played']))
        .round();
    if (report['p2']['results'][currentSet][prefix + '-out'] != null)
      report['p2']['results'][currentSet][prefix + '-out-%'] = (100 *
              (report['p2']['results'][currentSet][prefix + '-out'] /
                  report['p2']['results'][currentSet][prefix + '-played']))
          .round();
    if (report['p2']['results'][currentSet][prefix + '-net'] != null)
      report['p2']['results'][currentSet][prefix + '-net-%'] = (100 *
              (report['p2']['results'][currentSet][prefix + '-net'] /
                  report['p2']['results'][currentSet][prefix + '-played']))
          .round();
  }
}

Map matchStats({required Map match}) {
  final events = match['events'];
  final isMatchFinished = events.last['event'] == 'FinalScore';
  var lastScore =
      isMatchFinished ? events[match['events'].length - 2] : events.last;
  Map<String, dynamic> report = {
    'match-duration': [],
    'match-time': [],
    'scores': [],
    'p1': {'name': match['p1'], 'results': []},
    'p2': {'name': match['p2'], 'results': []}
  };

  var lastSet = lastScore['p1'].length;
  final lastScoreP1Set = lastScore['p1'][lastSet - 1];
  final lastScoreP2Set = lastScore['p2'][lastSet - 1];
  if (isMatchFinished &&
      (lastScoreP1Set['set'] == 0 &&
          lastScoreP2Set['set'] == 0 &&
          lastScoreP1Set['game'] == '0' &&
          lastScoreP2Set['game'] == '0')) lastSet--;
  Map statsBlueprint = {
    'points-played': 0,
    'points-won': 0,
    'points-won-%': 0,
    'return-points-played': 0,
    'return-points-won': 0,
    'return-points-won-%': 0,
    'service-points-played': 0,
    'service-points-won': 0,
    'service-points-won-%': 0,
    'winners': 0,
    'net-points-played': 0,
    'net-points-won': 0,
    'net-points-won-%': 0,
    'aces': 0,
    'aces-T': 0,
    'aces-body': 0,
    'aces-out-wide': 0,
    'double-faults': 0,
    '1st-serve-played': 0,
    '1st-serve-won': 0,
    '1st-serve-won-%': 0,
    '2nd-serve-played': 0,
    '2nd-serve-won': 0,
    '2nd-serve-won-%': 0,
    'games-serving-played': 0,
    'games-serving-won': 0,
    'games-serving-won-%': 0,
    'games-serving-with-game-point': 0,
    'games-receiving-played': 0,
    'games-receiving-won': 0,
    'games-receiving-won-%': 0,
    'games-receiving-with-break-point': 0,
    'break-points-played': 0,
    'break-points-won': 0,
    'break-points-won-%': 0,
    'game-points-played': 0,
    'game-points-won': 0,
    'game-points-won-%': 0,
    'forehand-played': 0,
    'forehand-won': 0,
    'forehand-won-%': 0,
    'forehand-won-down-the-line': 0,
    'forehand-won-middle': 0,
    'forehand-won-cross-court': 0,
    'forehand-out': 0,
    'forehand-out-%': 0,
    'forehand-out-down-the-line': 0,
    'forehand-out-middle': 0,
    'forehand-out-cross-court': 0,
    'forehand-net': 0,
    'forehand-net-%': 0,
    'forehand-net-down-the-line': 0,
    'forehand-net-middle': 0,
    'forehand-net-cross-court': 0,
    'backhand-played': 0,
    'backhand-won': 0,
    'backhand-won-%': 0,
    'backhand-won-down-the-line': 0,
    'backhand-won-middle': 0,
    'backhand-won-cross-court': 0,
    'backhand-out': 0,
    'backhand-out-%': 0,
    'backhand-out-down-the-line': 0,
    'backhand-out-middle': 0,
    'backhand-out-cross-court': 0,
    'backhand-net': 0,
    'backhand-net-%': 0,
    'backhand-net-down-the-line': 0,
    'backhand-net-middle': 0,
    'backhand-net-cross-court': 0,
    'smash-played': 0,
    'smash-won': 0,
    'smash-won-%': 0,
    'smash-won-down-the-line': 0,
    'smash-won-middle': 0,
    'smash-won-cross-court': 0,
    'smash-out': 0,
    'smash-out-%': 0,
    'smash-out-down-the-line': 0,
    'smash-out-middle': 0,
    'smash-out-cross-court': 0,
    'smash-net': 0,
    'smash-net-%': 0,
    'smash-net-down-the-line': 0,
    'smash-net-middle': 0,
    'smash-net-cross-court': 0,
    'volley-played': 0,
    'volley-won': 0,
    'volley-won-%': 0,
    'volley-won-down-the-line': 0,
    'volley-won-middle': 0,
    'volley-won-cross-court': 0,
    'volley-out': 0,
    'volley-out-%': 0,
    'volley-out-down-the-line': 0,
    'volley-out-middle': 0,
    'volley-out-cross-court': 0,
    'volley-net': 0,
    'volley-net-%': 0,
    'volley-net-down-the-line': 0,
    'volley-net-middle': 0,
    'volley-net-cross-court': 0,
    'drop-shot-played': 0,
    'drop-shot-won': 0,
    'drop-shot-won-%': 0,
    'drop-shot-won-down-the-line': 0,
    'drop-shot-won-middle': 0,
    'drop-shot-won-cross-court': 0,
    'drop-shot-out': 0,
    'drop-shot-out-%': 0,
    'drop-shot-out-down-the-line': 0,
    'drop-shot-out-middle': 0,
    'drop-shot-out-cross-court': 0,
    'drop-shot-net': 0,
    'drop-shot-net-%': 0,
    'drop-shot-net-down-the-line': 0,
    'drop-shot-net-middle': 0,
    'drop-shot-net-cross-court': 0,
  };
  for (var i = 0; i <= lastSet; i++) {
    report['match-time']
        .add({'start': match['createdAt'], 'end': match['createdAt']});
    report['p1']['results'].add({...statsBlueprint});
    report['p2']['results'].add({...statsBlueprint});
    report['scores'].add({});
  }
  report['scores'][0] = lastScore;

  var fault = false;
  var serving = "";
  for (var i = 0; i < events.length; i++) {
    final event = events[i];
    if ((event['event'] == 'Score') &&
        event.containsKey('server') &&
        event['p1'].last['tiebreak'] == null) {
      final server = event['server'];
      final receiver = server == 'p1' ? 'p2' : 'p1';
      final currentSet = event['p1'].length - 1;
      if (serving != server) {
        report[server]['results'][0]['games-serving-played']++;
        report[server]['results'][currentSet]['games-serving-played']++;
        report[receiver]['results'][0]['games-receiving-played']++;
        report[receiver]['results'][currentSet]['games-receiving-played']++;

        final servingCurrentGames = events[i][server].last['set'];
        final previousScoreIndex = i - 2;
        final servingPreviousGames =
            events[previousScoreIndex][server].last['set'];
        if (servingCurrentGames > servingPreviousGames) {
          report[server]['results'][0]['games-serving-won']++;
          report[server]['results'][currentSet]['games-serving-won']++;
        } else {
          report[receiver]['results'][0]['games-receiving-won']++;
          report[receiver]['results'][currentSet]['games-receiving-won']++;
        }
        if (report[server]['results'][0]['games-serving-played'] > 0)
          report[server]['results'][0]['games-serving-won-%'] = (100 *
                  (report[server]['results'][0]['games-serving-won'] /
                      report[server]['results'][0]['games-serving-played']))
              .round();
        if (report[server]['results'][currentSet]['games-serving-played'] > 0)
          report[server]['results'][currentSet]['games-serving-won-%'] = (100 *
                  (report[server]['results'][currentSet]['games-serving-won'] /
                      report[server]['results'][currentSet]
                          ['games-serving-played']))
              .round();
        if (report[receiver]['results'][0]['games-receiving-played'] > 0)
          report[receiver]['results'][0]['games-receiving-won-%'] = (100 *
                  (report[receiver]['results'][0]['games-receiving-won'] /
                      report[receiver]['results'][0]['games-receiving-played']))
              .round();
        if (report[receiver]['results'][currentSet]['games-receiving-played'] >
            0)
          report[receiver]['results'][currentSet]['games-receiving-won-%'] =
              (100 *
                      (report[receiver]['results'][currentSet]
                              ['games-receiving-won'] /
                          report[receiver]['results'][currentSet]
                              ['games-receiving-played']))
                  .round();
        serving = server;
      }
    }
    if (event['event'] == 'Rally') {
      final scoreBefore = events[i - 1];
      final scoreAfter = events[i + 1];
      final lastHitBy = event['lastHitBy'];
      final server = event['server'];
      final receiver = server == 'p1' ? 'p2' : 'p1';
      final winner = event['winner'];
      final shot = event['shot'];
      final direction = event['direction'];
      final hasDirection = direction != null;
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

        report[winner]['results'][0]['points-won']++;
        report[winner]['results'][currentSet]['points-won']++;
        updatePercentages(report, currentSet, 'points');

        if (depth == 'I') {
          report[winner]['results'][0]['winners']++;
          report[winner]['results'][currentSet]['winners']++;
        }

        if (shot == 'V' || shot == 'SM') {
          report[lastHitBy]['results'][0]['net-points-played']++;
          report[lastHitBy]['results'][currentSet]['net-points-played']++;
          if (lastHitBy == winner) {
            report[lastHitBy]['results'][0]['net-points-won']++;
            report[lastHitBy]['results'][currentSet]['net-points-won']++;
          }
          updatePercentages(report, currentSet, 'net-points');
        }

        report[server]['results'][0]['service-points-played']++;
        report[server]['results'][currentSet]['service-points-played']++;
        if (server == winner) {
          report[server]['results'][0]['service-points-won']++;
          report[server]['results'][currentSet]['service-points-won']++;
        }
        updatePercentages(report, currentSet, 'service-points');

        report[receiver]['results'][0]['return-points-played']++;
        report[receiver]['results'][currentSet]['return-points-played']++;
        if (receiver == winner) {
          report[receiver]['results'][0]['return-points-won']++;
          report[receiver]['results'][currentSet]['return-points-won']++;
        }
        updatePercentages(report, currentSet, 'return-points');

        if (lastHitBy == server &&
            winner == lastHitBy &&
            shot == 'SV' &&
            depth == 'I') {
          final serveDirection = (direction == 'CC'
              ? 'out-wide'
              : direction == 'M'
                  ? 'body'
                  : 'T');
          report[lastHitBy]['results'][0]['aces']++;
          report[lastHitBy]['results'][currentSet]['aces']++;
          if (hasDirection) {
            report[server]['results'][0]['aces-' + serveDirection]++;
            report[server]['results'][currentSet]['aces-' + serveDirection]++;
          }
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
            report[server]['results'][0]['2nd-serve-won']++;
            report[server]['results'][currentSet]['2nd-serve-won']++;
          }
          updatePercentages(report, currentSet, '2nd-serve');
        } else {
          report[server]['results'][0]['1st-serve-played']++;
          report[server]['results'][currentSet]['1st-serve-played']++;
          if (server == winner) {
            report[server]['results'][0]['1st-serve-won']++;
            report[server]['results'][currentSet]['1st-serve-won']++;
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
          if (receiver == winner) {
            report[receiver]['results'][0]['break-points-won']++;
            report[receiver]['results'][currentSet]['break-points-won']++;
          }
          updatePercentages(report, currentSet, 'break-points');
        }

        if ((scoreBefore[server][currentSet - 1]['game'] == '40' &&
                !['40', 'Ad']
                    .contains(scoreBefore[receiver][currentSet - 1]['game'])) ||
            (scoreBefore[server][currentSet - 1]['game'] == 'Ad')) {
          report[server]['results'][0]['game-points-played']++;
          report[server]['results'][currentSet]['game-points-played']++;
          if (server == winner) {
            report[server]['results'][0]['game-points-won']++;
            report[server]['results'][currentSet]['game-points-won']++;
          }
          updatePercentages(report, currentSet, 'game-points');
        }

        final ballDirection = (direction == 'CC'
            ? 'cross-court'
            : direction == 'M'
                ? 'middle'
                : 'down-the-line');

        if (shot == 'FH') {
          // FOREHAND
          report[lastHitBy]['results'][0]['forehand-played']++;
          report[lastHitBy]['results'][currentSet]['forehand-played']++;
          switch (depth) {
            case 'I':
              report[lastHitBy]['results'][0]['forehand-won']++;
              report[lastHitBy]['results'][currentSet]['forehand-won']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['forehand-won-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['forehand-won-' + ballDirection]++;
              }
              break;
            case 'O':
              report[lastHitBy]['results'][0]['forehand-out']++;
              report[lastHitBy]['results'][currentSet]['forehand-out']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['forehand-out-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['forehand-out-' + ballDirection]++;
              }
              break;
            case 'N':
              report[lastHitBy]['results'][0]['forehand-net']++;
              report[lastHitBy]['results'][currentSet]['forehand-net']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['forehand-net-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['forehand-net-' + ballDirection]++;
              }
              break;
          }
          updatePercentages(report, currentSet, 'forehand');
        }

        if (shot == 'BH') {
          // BACKHAND
          report[lastHitBy]['results'][0]['backhand-played']++;
          report[lastHitBy]['results'][currentSet]['backhand-played']++;
          switch (depth) {
            case 'I':
              report[lastHitBy]['results'][0]['backhand-won']++;
              report[lastHitBy]['results'][currentSet]['backhand-won']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['backhand-won-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['backhand-won-' + ballDirection]++;
              }
              break;
            case 'O':
              report[lastHitBy]['results'][0]['backhand-out']++;
              report[lastHitBy]['results'][currentSet]['backhand-out']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['backhand-out-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['backhand-out-' + ballDirection]++;
              }
              break;
            case 'N':
              report[lastHitBy]['results'][0]['backhand-net']++;
              report[lastHitBy]['results'][currentSet]['backhand-net']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['backhand-net-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['backhand-net-' + ballDirection]++;
              }
              break;
          }
          updatePercentages(report, currentSet, 'backhand');
        }

        if (shot == 'SM') {
          // SMASH
          report[lastHitBy]['results'][0]['smash-played']++;
          report[lastHitBy]['results'][currentSet]['smash-played']++;
          switch (depth) {
            case 'I':
              report[lastHitBy]['results'][0]['smash-won']++;
              report[lastHitBy]['results'][currentSet]['smash-won']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]['smash-won-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['smash-won-' + ballDirection]++;
              }
              break;
            case 'O':
              report[lastHitBy]['results'][0]['smash-out']++;
              report[lastHitBy]['results'][currentSet]['smash-out']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]['smash-out-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['smash-out-' + ballDirection]++;
              }
              break;
            case 'N':
              report[lastHitBy]['results'][0]['smash-net']++;
              report[lastHitBy]['results'][currentSet]['smash-net']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]['smash-net-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['smash-net-' + ballDirection]++;
              }
              break;
          }
          updatePercentages(report, currentSet, 'smash');
        }

        if (shot == 'V') {
          // VOLLEY
          report[lastHitBy]['results'][0]['volley-played']++;
          report[lastHitBy]['results'][currentSet]['volley-played']++;
          switch (depth) {
            case 'I':
              report[lastHitBy]['results'][0]['volley-won']++;
              report[lastHitBy]['results'][currentSet]['volley-won']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['volley-won-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['volley-won-' + ballDirection]++;
              }
              break;
            case 'O':
              report[lastHitBy]['results'][0]['volley-out']++;
              report[lastHitBy]['results'][currentSet]['volley-out']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['volley-out-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['volley-out-' + ballDirection]++;
              }
              break;
            case 'N':
              report[lastHitBy]['results'][0]['volley-net']++;
              report[lastHitBy]['results'][currentSet]['volley-net']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['volley-net-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['volley-net-' + ballDirection]++;
              }
              break;
          }
          updatePercentages(report, currentSet, 'volley');
        }

        if (shot == 'DS') {
          // DROP SHOT
          report[lastHitBy]['results'][0]['drop-shot-played']++;
          report[lastHitBy]['results'][currentSet]['drop-shot-played']++;
          switch (depth) {
            case 'I':
              report[lastHitBy]['results'][0]['drop-shot-won']++;
              report[lastHitBy]['results'][currentSet]['drop-shot-won']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['drop-shot-won-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['drop-shot-won-' + ballDirection]++;
              }
              break;
            case 'O':
              report[lastHitBy]['results'][0]['drop-shot-out']++;
              report[lastHitBy]['results'][currentSet]['drop-shot-out']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['drop-shot-out-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['drop-shot-out-' + ballDirection]++;
              }
              break;
            case 'N':
              report[lastHitBy]['results'][0]['drop-shot-net']++;
              report[lastHitBy]['results'][currentSet]['drop-shot-net']++;
              if (hasDirection) {
                report[lastHitBy]['results'][0]
                    ['drop-shot-net-' + ballDirection]++;
                report[lastHitBy]['results'][currentSet]
                    ['drop-shot-net-' + ballDirection]++;
              }
              break;
          }
          updatePercentages(report, currentSet, 'drop-shot');
        }
      }
    }
  }

  for (var i = 0; i <= lastSet; i++) {
    final duration = report['match-time'][i]['end']
        .difference(report['match-time'][i]['start']);
    report['match-duration'].add(duration);
  }
  report['match-duration'][0] =
      report['match-duration'].reduce((value, element) => value + element);

  final matchWinner = report['p1']['results'][0]['points-won'] >=
          report['p2']['results'][0]['points-won']
      ? 'p1'
      : 'p2';
  report['winner'] = matchWinner;
  report['loser'] = matchWinner == 'p1' ? 'p2' : 'p1';
  report['score'] = formatStatsScore(match, events.last, matchWinner);
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
