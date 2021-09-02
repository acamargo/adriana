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

Map newScoreFromRally(createdAt, match, previousScore, rally) {
  Map newScore = {...previousScore};
  newScore['createdAt'] = createdAt;
  newScore['isServiceFault'] = rally['shot'] == 'F';

  if (rally['winner'] != null) {
    var looser = rally['winner'] == 'p1' ? 'p2' : 'p1';
    if (newScore[rally['winner']].last['game'] == '0') {
      newScore[rally['winner']].last['game'] = '15';
    } else if (newScore[rally['winner']].last['game'] == '15') {
      newScore[rally['winner']].last['game'] = '30';
    } else if (newScore[rally['winner']].last['game'] == '30') {
      newScore[rally['winner']].last['game'] = '40';
    } else if (newScore[rally['winner']].last['game'] == '40' &&
        newScore[looser].last['game'] == '40') {
      newScore[rally['winner']].last['game'] = 'Ad';
    } else if (newScore[rally['winner']].last['game'] == '40' &&
        newScore[looser].last['game'] == 'Ad') {
      newScore[rally['winner']].last['game'] = '40';
      newScore[looser].last['game'] = '40';
    } else {
      newScore[rally['winner']].last['set']++;
      newScore[rally['winner']].last['game'] = '0';
      newScore[looser].last['game'] = '0';
      newScore['server'] = newScore['server'] == 'p1' ? 'p2' : 'p1';

      if ((newScore[rally['winner']].last['set'] == 6 &&
              newScore[looser].last['set'] <= 4) ||
          (newScore[rally['winner']].last['set'] == 7 &&
              newScore[looser].last['set'] == 5)) {
        newScore['p1'].add({'game': '0', 'tiebreak': null, 'set': 0});
        newScore['p2'].add({'game': '0', 'tiebreak': null, 'set': 0});
      } else if (newScore[rally['winner']].last['set'] == 6 &&
          newScore[looser].last['set'] == 6) {
        newScore['p1'].last['tiebreak'] = 0;
        newScore['p2'].last['tiebreak'] = 0;
      }
    }
    //newScore['winner'] = null;
    newScore['isServiceFault'] = false;
    newScore['courtSide'] = newScore['courtSide'] == 'deuce' ? 'ad' : 'deuce';
    newScore['pointNumber']++;
  }

  if (newScore['isServiceFault']) {
    newScore['state'] = 'second service, ${match[newScore['server']]}';
  } else {
    newScore['state'] = 'first service, ${match[newScore['server']]}';
  }

  return newScore;
}
