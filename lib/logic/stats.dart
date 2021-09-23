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
    if (event['type'] == 'Rally') {
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
      }
    }
  }
  return report;
}
