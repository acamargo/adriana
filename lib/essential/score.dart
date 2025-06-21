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

  if (p1SetLast['set'] == 7 && p2SetLast['set'] == 6) {
    return '$p1Name ${p1SetLast['set']}-${p2SetLast['set']}(${p2SetLast['tiebreak']})';
  } else if (p2SetLast['set'] == 7 && p1SetLast['set'] == 6) {
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
    final isFinished = (playerMax >= 7 && (playerMax - playerMin) >= 2);
    if (isFinished)
      return (playerServingSet['tiebreak'] == playerMax)
          ? '$playerServingSetGames-$playerReceivingSetGames($playerMin)'
          : '($playerMin)$playerServingSetGames-$playerReceivingSetGames';
    else
      return '$playerServingSetGames-$playerReceivingSetGames';
  } else {
    return '$playerServingSetGames-$playerReceivingSetGames';
  }
}

bool switchEnds(_score) {
  // final _score = score();
  final bool isTieBreak =
      _score['p1'].last['set'] == 6 && _score['p2'].last['set'] == 6;
  if (isTieBreak) {
    final int pointsPlayed =
        _score['p1'].last['tiebreak'] + _score['p2'].last['tiebreak'];
    final bool _switchEnds = pointsPlayed > 0 && pointsPlayed % 6 == 0;
    return _switchEnds;
  }
  final int gamesPlayed = _score['p1'].last['set'] + _score['p2'].last['set'];
  final bool _switchEnds = _score['p1'].last['game'] == '0' &&
      _score['p2'].last['game'] == '0' &&
      gamesPlayed > 0 &&
      gamesPlayed % 2 != 0;
  return _switchEnds;
}

bool isNewGame(Map score) {
  return score['p1'].last['game'] == '0' &&
      score['p2'].last['game'] == '0' &&
      !score['isServiceFault'] &&
      score['p1'].last['set'] != 6 &&
      score['p2'].last['set'] != 6;
}

String spokenScore(Map match) {
  final rally = match['events'][match['events'].length - 2];
  final score = match['events'].last;
  final server = score['server'];
  final receiver = server == 'p1' ? 'p2' : 'p1';
  final server_set = score[server].last['set'];
  final receiver_set = score[receiver].last['set'];
  var set_score = "${server_set} ${receiver_set}";
  if (server_set == receiver_set) {
    set_score = "${server_set} all";
  }
  if (switchEnds(score)) {
    final winner = rally['winner'];
    final server_tb = score[server].last['tiebreak'];
    final receiver_tb = score[receiver].last['tiebreak'];
    var message = "game ${match[winner]}. switch ends. ${match[server]} ${set_score}";
    if (server_set == 6 && receiver_set == 6)
      message = "$server_tb $receiver_tb. switch ends";
    return message;
  } else if (isNewGame(score)) {
    final winner = rally['winner'];
    return "game ${match[winner]}. ${match[server]} ${set_score}";
  } else {
    final server = score['server'];
    final server_game = score[server].last['game'];
    final server_set = score[server].last['set'];
    final server_score = server_game == '0' ? 'love' : server_game;
    final receiver = server == 'p1' ? 'p2' : 'p1';
    final receiver_game = score[receiver].last['game'];
    final receiver_set = score[receiver].last['set'];
    final receiver_score = receiver_game == '0' ? 'love' : receiver_game;
    if (score['isServiceFault'])
      return "fault";
    else if (server_set == 6 && receiver_set == 6) {
      final server_tb = score[server].last['tiebreak'];
      final receiver_tb = score[receiver].last['tiebreak'];
      if (server_tb == 0 && receiver_tb == 0)
        return "tiebreak";
      else if (server_tb == receiver_tb)
        return "${server_tb} all";
      else
        return "$server_tb $receiver_tb";
    } else if (server_score == 'Ad')
      return "Advantage ${match[server]}";
    else if (receiver_score == 'Ad')
      return 'Advantage ${match[receiver]}';
    else if (server_score == receiver_score) {
      if (server_score == '40')
        return "deuce";
      else
        return "$server_score all";
    } else {
      return "${server_score} ${receiver_score}";
    }
  }
}

String formatScore(Map match, Map score, String playerServing) {
  var courtEnd = score['courtEnd'];
  var playerServingName = match[playerServing];
  var playerReceiving = playerServing == 'p1' ? 'p2' : 'p1';
  final isTieBreak = score[playerServing].last['set'] == 6 &&
      score[playerReceiving].last['set'] == 6;
  var playerServingGame =
      score[playerServing].last[isTieBreak ? 'tiebreak' : 'game'];
  var playerReceivingGame =
      score[playerReceiving].last[isTieBreak ? 'tiebreak' : 'game'];
  var result = [
    if (courtEnd != null) courtEnd,
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

List<String> statsScoreList(Map score, String playerServing) {
  List<String> result = [];
  var playerReceiving = playerServing == 'p1' ? 'p2' : 'p1';
  final scorePlayerServingLastSet = score[playerServing].last['set'];
  final scorePlayerReceivingLastSet = score[playerReceiving].last['set'];
  final isTieBreak =
      scorePlayerServingLastSet == 6 && scorePlayerReceivingLastSet == 6;
  var playerServingGame =
      score[playerServing].last[isTieBreak ? 'tiebreak' : 'game'];
  var playerReceivingGame =
      score[playerReceiving].last[isTieBreak ? 'tiebreak' : 'game'];
  var game = '$playerServingGame/$playerReceivingGame';
  if (game != '0/0') result.add(game);
  for (var i = 0; i < score[playerServing].length; i++) {
    result.add(
        formatScoreSet(score[playerServing][i], score[playerReceiving][i]));
  }
  final isMatchFinished = score['event'] == 'FinalScore';
  if (isMatchFinished &&
      scorePlayerServingLastSet == 0 &&
      scorePlayerReceivingLastSet == 0) result.removeAt(result.length - 1);
  return result;
}

String formatStatsScore(Map match, Map score, String playerServing) {
  var playerServingName = match[playerServing];
  return ([playerServingName] + statsScoreList(score, playerServing)).join(' ');
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
  newScore['courtEnd'] = coinToss['courtEnd'];
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
    var loser = rally['winner'] == 'p1' ? 'p2' : 'p1';
    var isTiebreak =
        newScore['p1'].last['set'] == 6 && newScore['p2'].last['set'] == 6;
    if (isTiebreak) {
      newScore[rally['winner']].last['tiebreak']++;
      var winnerPoints = newScore[rally['winner']].last['tiebreak'];
      var loserPoints = newScore[loser].last['tiebreak'];
      if (winnerPoints >= 7 && loserPoints <= (winnerPoints - 2)) {
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
          newScore[loser].last['game'] == '40') {
        newScore[rally['winner']].last['game'] = 'Ad';
      } else if (newScore[rally['winner']].last['game'] == '40' &&
          newScore[loser].last['game'] == 'Ad') {
        newScore[rally['winner']].last['game'] = '40';
        newScore[loser].last['game'] = '40';
      } else {
        newScore[rally['winner']].last['set']++;
        newScore[rally['winner']].last['game'] = '0';
        newScore[loser].last['game'] = '0';
        newScore['server'] = newScore['server'] == 'p1' ? 'p2' : 'p1';

        if ((newScore[rally['winner']].last['set'] == 6 &&
                newScore[loser].last['set'] <= 4) ||
            (newScore[rally['winner']].last['set'] == 7 &&
                newScore[loser].last['set'] == 5)) {
          newScore['p1'].add({'game': '0', 'tiebreak': null, 'set': 0});
          newScore['p2'].add({'game': '0', 'tiebreak': null, 'set': 0});
        } else if (newScore[rally['winner']].last['set'] == 6 &&
            newScore[loser].last['set'] == 6) {
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

  //          L | R
  // 0  G1  *P1 | P2
  // 1  G2  *P2 | P1
  // 2  G3   P2 | P1*
  // 3  G4   P1 | P2*
  // 4  G5  *P1 | P2
  // 5  G6  *P2 | P1
  // 6  G7   P2 | P1*
  // 7  G8   P1 | P2*
  // 8  G9  *P1 | P2
  // 9  G10 *P2 | P1
  // 10 G11  P2 | P1*
  // 11 G12  P1 | P2*
  // 0  T1  *P1 | P2
  // 1  T2   P1 | P2*
  // 2  T3   P1 | P2*
  // 3  T4  *P1 | P2
  // 4  T5  *P1 | P2
  // 5  T6   P1 | P2*
  // 6  T7  *P2 | P1
  final Map coinTossEvent = match['events']
      .firstWhere((e) => e['event'] == 'CoinToss', orElse: () => {});
  if (coinTossEvent.isNotEmpty) {
    final int gamesPlayed =
        newScore['p1'].last['set'] + newScore['p2'].last['set'];
    final bool isTieBreak =
        newScore['p1'].last['set'] == 6 && newScore['p2'].last['set'] == 6;
    final String coinTossCourtEnd = coinTossEvent['courtEnd'];
    final List<int> gamesSameEnd = [0, 1, 4, 5, 8, 9];
    if (isTieBreak) {
      final int pointsPlayed =
          newScore['p1'].last['tiebreak'] + newScore['p2'].last['tiebreak'];
      final List<int> pointsSameEnd = [0, 3, 4];
      if (pointsSameEnd.contains(pointsPlayed % 6)) {
        newScore['courtEnd'] = coinTossCourtEnd;
      } else {
        newScore['courtEnd'] = coinTossCourtEnd == 'L' ? 'R' : 'L';
      }
    } else if (gamesSameEnd.contains(gamesPlayed)) {
      newScore['courtEnd'] = coinTossCourtEnd;
    } else {
      newScore['courtEnd'] = coinTossCourtEnd == 'L' ? 'R' : 'L';
    }
  }

  return newScore;
}
