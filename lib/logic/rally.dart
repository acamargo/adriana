Map newRallyEvent({
  required DateTime createdAt,
  required Map match,
  required String player,
  required String shot,
  required String direction,
  required String depth,
}) {
  Map score = match['events'].last;
  var winner;
  if (shot == 'SV' &&
      (depth == 'O' || depth == 'N') &&
      !(score['isServiceFault'] == true)) {
    winner = null;
  } else if (['N', 'O'].contains(depth)) {
    winner = player == 'p1' ? 'p2' : 'p1';
  } else if (['I'].contains(depth)) {
    winner = player;
  }

  return {
    'event': 'Rally',
    'createdAt': createdAt,
    'server': score['server'],
    'lastHitBy': player,
    'shot': shot,
    'depth': depth,
    'direction': direction,
    'winner': winner,
  };
}

Map whatWasTheShotHitOptions({required bool isServing}) {
  return {
    'options': [
      {'label': 'BACKHAND', 'short': 'BH', 'value': 'BH'},
      {'label': 'OVERHEAD', 'short': 'OH', 'value': 'SM'},
      if (isServing) {'label': 'SERVE', 'short': 'S', 'value': 'SV'},
      {'label': 'DROP SHOT', 'short': 'DS', 'value': 'DS'},
      {'label': 'VOLLEY', 'short': 'V', 'value': 'V'},
      {'label': 'FOREHAND', 'short': 'FH', 'value': 'FH'},
    ]
  };
}

Map whatWasTheDirectionOptions({required String shot}) {
  return {
    'options': [
      {'label': (shot == 'SV') ? 'OUT WIDE' : 'CROSS COURT', 'value': 'CC'},
      {'label': (shot == 'SV') ? 'BODY' : 'MIDDLE', 'value': 'M'},
      {'label': (shot == 'SV') ? 'T' : 'DOWN THE LINE', 'value': 'DTL'}
    ]
  };
}

Map whereDidTheBallLandOptions({required String shot}) {
  return {
    'options': [
      {'label': 'INTO THE NET', 'value': 'N'},
      {'label': (shot == 'SV') ? 'ACE' : 'WINNER', 'value': 'I'},
      {'label': 'OUT', 'value': 'O'},
    ]
  };
}

String formatRally(Map match, Map event) {
  final lastHitBy = event['lastHitBy'];
  final playerName = match[lastHitBy];
  final shot = event['shot'];
  final shotName = whatWasTheShotHitOptions(
          isServing: event['server'] == event['lastHitBy'])['options']
      .where((option) => option['value'] == shot)
      .first['label']
      .toLowerCase();
  final depth = event['depth'];
  final depthName = whereDidTheBallLandOptions(shot: shot)['options']
      .where((option) => option['value'] == depth)
      .first['label']
      .toLowerCase();

  if (event.containsKey('direction')) {
    final direction = event['direction'];
    final directionName = whatWasTheDirectionOptions(shot: shot)['options']
        .where((option) => option['value'] == direction)
        .first['label']
        .toLowerCase();
    return '$playerName $shotName $directionName $depthName';
  } else {
    return '$playerName $shotName $depthName';
  }
}
