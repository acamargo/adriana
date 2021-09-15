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
  if (shot == "F") {
    winner = null;
  } else if (shot == "DF") {
    winner = whoIsReceiving;
  } else if (shot == "A") {
    winner = whoIsServing;
  } else if (['N', 'L', 'W'].contains(depth)) {
    winner = player == "p1" ? "p2" : "p1";
  } else if (['S', 'D'].contains(depth)) {
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
  var result = {'label': 'What was the shot hit?', 'options': []};
  if (consistency != '') {
    result['options'] = [
      if (isServing && consistency == '1') {'label': 'ace', 'value': 'A'},
      if (isServing && consistency == '1' && !isServiceFault)
        {'label': 'fault', 'value': 'F'},
      if (isServing && consistency == '1' && isServiceFault)
        {'label': 'double fault', 'value': 'DF'},
      {'label': 'groundstroke forehand', 'value': 'GFH'},
      {'label': 'groundstroke backhand', 'value': 'GBH'},
      {'label': 'volley forehand', 'value': 'VFH'},
      {'label': 'volley backhand', 'value': 'VBH'},
      {'label': 'smash', 'value': 'SH'},
      {'label': 'lob', 'value': 'L'},
      {'label': 'passing shot forehand', 'value': 'PSFH'},
      {'label': 'passing shot backhand', 'value': 'PSBH'},
      {'label': 'tweeter', 'value': 'TW'},
      {'label': 'groundstroke forehand', 'value': 'GFH'},
      {'label': 'drop shot forehand', 'value': 'DSFH'},
      {'label': 'drop shot backhand', 'value': 'DSBH'},
      {'label': 'half-volley forehand', 'value': 'HVFH'},
      {'label': 'half-volley backhand', 'value': 'HVBH'}
    ];
  }
  return result;
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
