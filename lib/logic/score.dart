String formatScore(Map match, Map score) {
  var playerServing = score['server'];
  var playerServingName = match[playerServing];
  var playerReceiving = playerServing == "p1" ? "p2" : "p1";
  var playerServingGame = score[playerServing].last['game'];
  var playerReceivingGame = score[playerReceiving].last['game'];
  var playerServingSet = score[playerServing].last['set'];
  var playerReceivingSet = score[playerReceiving].last['set'];
  return "$playerServingName $playerServingGame/$playerReceivingGame $playerServingSet-$playerReceivingSet";
}

Map newFirstScore(DateTime createdAt) {
  return {
    'event': 'Score',
    'createdAt': createdAt,
    'pointNumber': 0,
    'p1': [
      {'game': '0', 'tiebreak': null, 'set': 0}
    ],
    'p2': [
      {'game': '0', 'tiebreak': null, 'set': 0}
    ],
    'state': 'waiting coin toss',
  };
}
