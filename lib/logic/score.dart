import 'dart:math';

String formatScoreSet(Map playerServingSet, Map playerReceivingSet) {
  return (playerServingSet['tiebreak'] != null &&
          playerReceivingSet['tiebreak'] != null)
      ? '${playerServingSet['set']}-${playerReceivingSet['set']}(${min(playerServingSet['tiebreak'] as int, playerReceivingSet['tiebreak'] as int)})'
      : '${playerServingSet['set']}-${playerReceivingSet['set']}';
}

String formatScore(Map match, Map score) {
  var playerServing = score['server'];
  var playerServingName = match[playerServing];
  var playerReceiving = playerServing == "p1" ? "p2" : "p1";
  var playerServingGame = score[playerServing].last['game'];
  var playerReceivingGame = score[playerReceiving].last['game'];
  var result = [playerServingName, '$playerServingGame/$playerReceivingGame'];
  for (var i = 0; i < score[playerServing].length; i++) {
    result.add(
        formatScoreSet(score[playerServing][i], score[playerReceiving][i]));
  }
  return result.join(' ');
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

Map newScoreFromCoinToss(match, coinToss) {
  final previousScore = match['events'].last;
  Map newScore = {...previousScore};
  newScore['createdAt'] = DateTime.now();
  newScore['server'] = coinToss['server'];
  newScore['isServiceFault'] = false;
  newScore['courtSide'] = 'deuce';
  newScore['state'] = 'first service, ${match[newScore['server']]}';
  return newScore;
}
