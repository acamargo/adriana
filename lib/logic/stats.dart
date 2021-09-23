Map playerParticipation({required List<Map> events}) {
  var report = <String, dynamic>{
    'points': 0,
    'p1': {
      'points': 0,
      'service': {'points': 0, 'double-fault': 0, 'ace': 0},
      'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
      'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
      'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
      'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
    },
    'p2': {
      'points': 0,
      'service': {'points': 0, 'double-fault': 0, 'ace': 0},
      'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
      'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
      'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
      'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
    }
  };
  for (var i = 0; i < events.length; i++) {
    final event = events[i];
    if (event['type'] == 'Rally') {
      final winner = event['winner'];
      report['points']++;
      report[winner]['points']++;
      if (event['shot'] == 'SV') {
        report[winner]['service']['points']++;
        if (event['lastHitBy'] == winner && event['depth'] == 'I')
          report[winner]['service']['ace']++;
      }
    }
  }
  return report;
}
