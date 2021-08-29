Map newCoinTossEvent({
  required String winner,
  required DateTime createdAt,
}) {
  return {
    'event': 'CoinToss',
    'createdAt': createdAt,
    'server': winner,
  };
}
