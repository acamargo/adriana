import 'dart:math';
import 'dart:core';

String formatStatsSet(String p1Name, String p2Name, Map score) {
  var numberOfSets = score['p1'].length;
  var p1SetLast = score['p1'].last;
  var p2SetLast = score['p2'].last;

  if (p1SetLast['set'] == 0 && p2SetLast['set'] == 0 && numberOfSets > 1) {
    numberOfSets--;
    p1SetLast = score['p1'][numberOfSets - 1];
    p2SetLast = score['p2'][numberOfSets - 1];
  }

  if (p1SetLast['set'] == 7) {
    return '$p1Name ${p1SetLast['set']}-${p2SetLast['set']}(${p2SetLast['tiebreak']})';
  } else if (p2SetLast['set'] == 7) {
    return '$p2Name ${p2SetLast['set']}-${p1SetLast['set']}(${p1SetLast['tiebreak']})';
  } else if (p1SetLast['set'] == 6 && p2SetLast['set'] == 6) {
    if (p1SetLast['tiebreak'] >= p2SetLast['tiebreak'])
      return '$p1Name ${p1SetLast['tiebreak']}/${p2SetLast['tiebreak']} ${p1SetLast['set']}-${p2SetLast['set']}';
    else
      return '$p2Name ${p2SetLast['tiebreak']}/${p1SetLast['tiebreak']} ${p2SetLast['set']}-${p1SetLast['set']}';
  } else if (p1SetLast['set'] >= p2SetLast['set']) {
    var p1Game = '${p1SetLast['game']}/${p2SetLast['game']}';
    if (p1Game == '0/0')
      return '$p1Name ${p1SetLast['set']}-${p2SetLast['set']}';
    else
      return '$p1Name $p1Game ${p1SetLast['set']}-${p2SetLast['set']}';
  } else {
    var p2Game = '${p2SetLast['game']}/${p1SetLast['game']}';
    if (p2Game == '0/0')
      return '$p2Name ${p2SetLast['set']}-${p1SetLast['set']}';
    else
      return '$p2Name $p2Game ${p2SetLast['set']}-${p1SetLast['set']}';
  }
}

String formatScoreSet(Map playerServingSet, Map playerReceivingSet) {
  final playerServingSetGames = playerServingSet['set'] as int;
  final playerReceivingSetGames = playerReceivingSet['set'] as int;
  final isTieBreak = min(playerServingSetGames, playerReceivingSetGames) == 6;
  if (isTieBreak) {
    final playerMax = max(playerServingSet['tiebreak'] as int,
        playerReceivingSet['tiebreak'] as int);
    final playerMin = min(playerServingSet['tiebreak'] as int,
        playerReceivingSet['tiebreak'] as int);
    final isFinished = (playerMax >= 7 && (playerMax - playerMin) <= 2);
    if (isFinished)
      return '$playerServingSetGames-$playerReceivingSetGames($playerMin)';
    else
      return '$playerServingSetGames-$playerReceivingSetGames';
  } else {
    return '$playerServingSetGames-$playerReceivingSetGames';
  }
}

String formatScore(Map match, Map score, String playerServing) {
  var playerServingName = match[playerServing];
  var playerReceiving = playerServing == 'p1' ? 'p2' : 'p1';
  final isTieBreak = score[playerServing].last['set'] == 6 &&
      score[playerReceiving].last['set'] == 6;
  var playerServingGame =
      score[playerServing].last[isTieBreak ? 'tiebreak' : 'game'];
  var playerReceivingGame =
      score[playerReceiving].last[isTieBreak ? 'tiebreak' : 'game'];
  var result = [
    playerServingName,
    if (score['isServiceFault'] == true) 'fault',
    '$playerServingGame/$playerReceivingGame'
  ];
  for (var i = 0; i < score[playerServing].length; i++) {
    result.add(
        formatScoreSet(score[playerServing][i], score[playerReceiving][i]));
  }
  return result.join(' ');
}

String formatStatsScore(Map match, Map score, String playerServing) {
  var playerServingName = match[playerServing];
  var playerReceiving = playerServing == 'p1' ? 'p2' : 'p1';
  final isTieBreak = score[playerServing].last['set'] == 6 &&
      score[playerReceiving].last['set'] == 6;
  var playerServingGame =
      score[playerServing].last[isTieBreak ? 'tiebreak' : 'game'];
  var playerReceivingGame =
      score[playerReceiving].last[isTieBreak ? 'tiebreak' : 'game'];
  var result = [playerServingName];
  var game = '$playerServingGame/$playerReceivingGame';
  if (game != '0/0') result.add(game);
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
  newScore['p1'] = previousScore['p1']
      .map((element) => <String, dynamic>{...element})
      .toList();
  newScore['p2'] = previousScore['p2']
      .map((element) => <String, dynamic>{...element})
      .toList();
  newScore['createdAt'] = createdAt;
  newScore['isServiceFault'] = (rally['shot'] == 'SV' &&
      (rally['depth'] == 'O' || rally['depth'] == 'N'));

  if (rally['winner'] != null) {
    var looser = rally['winner'] == 'p1' ? 'p2' : 'p1';
    var isTiebreak =
        newScore['p1'].last['set'] == 6 && newScore['p2'].last['set'] == 6;
    if (isTiebreak) {
      newScore[rally['winner']].last['tiebreak']++;
      var winnerPoints = newScore[rally['winner']].last['tiebreak'];
      var looserPoints = newScore[looser].last['tiebreak'];
      if (winnerPoints >= 7 && looserPoints <= (winnerPoints - 2)) {
        newScore[rally['winner']].last['set']++;
        newScore['p1'].add({'game': '0', 'tiebreak': 0, 'set': 0});
        newScore['p2'].add({'game': '0', 'tiebreak': 0, 'set': 0});
        newScore.remove('tiebreakPointNumber');
        newScore['courtSide'] = 'deuce'; // to become deuce above
        newScore['server'] = newScore['tiebreakServer'] == 'p1' ? 'p2' : 'p1';
        newScore.remove('tiebreakServer');
      } else {
        if ((newScore['tiebreakPointNumber'] - 1) % 2 == 0)
          newScore['server'] = newScore['server'] == 'p1' ? 'p2' : 'p1';
        newScore['tiebreakPointNumber']++;
        newScore['courtSide'] =
            newScore['courtSide'] == 'deuce' ? 'ad' : 'deuce';
      }
    } else {
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
          newScore['tiebreakServer'] = newScore['server'];
          newScore['tiebreakPointNumber'] = 1;
        }
      }
      newScore['courtSide'] = newScore['courtSide'] == 'deuce' ? 'ad' : 'deuce';
    }
    newScore['isServiceFault'] = false;
    //newScore['courtSide'] = newScore['courtSide'] == 'deuce' ? 'ad' : 'deuce';
    newScore['pointNumber']++;
  }

  if (newScore['isServiceFault']) {
    newScore['state'] = 'second service, ${match[newScore['server']]}';
  } else {
    newScore['state'] = 'first service, ${match[newScore['server']]}';
  }

  return newScore;
}
