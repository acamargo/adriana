Map newCoinTossEvent({
  required String winner,
  required String courtEnd,
  required DateTime createdAt,
}) {
  return {
    'event': 'CoinToss',
    'createdAt': createdAt,
    'server': winner,
    'courtEnd': courtEnd,
  };
}
