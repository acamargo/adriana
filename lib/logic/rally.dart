Map newRallyEvent({
  required DateTime createdAt,
  required Map match,
  required String player,
  required String shot,
  required String depth,
}) {
  Map score = match['events'].last;
  var winner;
  if (shot == "SV" &&
      (depth == 'O' || depth == 'N') &&
      !(score['isServiceFault'] == true)) {
    winner = null;
  } else if (['N', 'O'].contains(depth)) {
    winner = player == "p1" ? "p2" : "p1";
  } else if (['I'].contains(depth)) {
    winner = player;
  }

  return {
    'event': 'Rally',
    'createdAt': createdAt,
    'lastHitBy': player,
    'shot': shot,
    'depth': depth,
    'winner': winner,
  };
}

Map whatWasTheShotHitOptions({required bool isServing}) {
  return {
    'options': [
      {'label': 'BACKHAND', 'value': 'BH'},
      {'label': 'SMASH', 'value': 'SM'},
      if (isServing) {'label': 'SERVE', 'value': 'SV'},
      {'label': 'VOLLEY', 'value': 'V'},
      {'label': 'FOREHAND', 'value': 'FH'},
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
