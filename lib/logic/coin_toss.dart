Map buildScoreFromCoinToss(match, coinToss) {
  final previousScore = match['events'].last;
  Map newScore = {...previousScore};
  newScore['createdAt'] = DateTime.now();
  newScore['server'] = coinToss['server'];
  newScore['isServiceFault'] = false;
  newScore['courtSide'] = 'deuce';
  newScore['state'] = 'first service, ${match[newScore['server']]}';
  return newScore;
}
