Map newRallyEvent({
  required DateTime createdAt,
  required Map match,
  required String player,
  required String shot,
  required String direction,
  required String depth,
  required String consistency,
}) {
  Map score = match['events'].last;
  String whoIsServing = score['server'];
  String whoIsReceiving = whoIsServing == "p1" ? "p2" : "p1";
  var winner;
  if (shot == "SV" &&
      (depth == 'O' || depth == 'N') &&
      !score['isServiceFault']) {
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
    'consistency': consistency,
    'shot': shot,
    'direction': direction,
    'depth': depth,
    'winner': winner,
  };
}

Map whatWasTheRallyLengthOptions(
    {required String player,
    required String consistency,
    required bool isServing}) {
  var result = {'label': 'What was the rally length?', 'options': []};
  if (player != '') {
    if (isServing) {
      result['options'] = [
        {'label': 'one shot', 'value': '1'},
        {'label': 'three shots or more', 'value': '3'},
      ];
    } else {
      result['options'] = [
        {'label': 'two shots', 'value': '2'},
        {'label': 'four shots or more', 'value': '4'}
      ];
    }
  }
  return result;
}

Map whatWasTheShotHitOptions(
    {required String consistency,
    required bool isServing,
    required bool isServiceFault}) {
  return {
    'options': [
      {'label': 'FOREHAND', 'value': 'FH'},
      {'label': 'BACKHAND', 'value': 'BH'},
      {'label': 'SMASH', 'value': 'SM'},
      {'label': 'VOLLEY', 'value': 'V'},
      {'label': 'SERVE', 'value': 'SV'}
    ]
  };
}

Map whatWasTheBallDirectionOptions(
    {required String shot,
    required bool isServiceStroke,
    required String whoIsReceiving}) {
  var result = {'label': 'What was the ball direction?', 'options': []};
  if (shot != '') {
    if (isServiceStroke) {
      result['options'] = [
        {'label': "${whoIsReceiving}'s forehand", 'value': 'FH'},
        {'label': "${whoIsReceiving}'s body", 'value': 'B'},
        {'label': "${whoIsReceiving}'s backhand", 'value': 'BH'},
        {'label': 'wide', 'value': 'W'}
      ];
    } else {
      result['options'] = [
        {'label': 'cross-court', 'value': 'CC'},
        {'label': 'middle-court', 'value': 'MD'},
        {'label': 'down-the-line', 'value': 'DL'},
      ];
    }
  }
  return result;
}

Map whereDidTheBallLandOptions(
    {required String direction, required String shot}) {
  return {
    'options': [
      {'label': 'NET', 'value': 'N'},
      {'label': 'IN', 'value': 'I'},
      {'label': 'OUT', 'value': 'O'},
    ]
  };
}
