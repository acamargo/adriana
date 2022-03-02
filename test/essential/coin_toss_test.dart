import 'package:test/test.dart';

import 'package:adriana/essential/coin_toss.dart';

void main() {
  group('Given a DateTime and winner', () {
    group('When a new CoinToss event is created', () {
      test('Then the event has the required properties', () {
        final now = DateTime.now();
        expect(
            newCoinTossEvent(winner: 'p1', createdAt: now),
            allOf([
              containsPair('event', 'CoinToss'),
              containsPair('createdAt', now),
              containsPair('server', 'p1'),
            ]));
      });
    });
  });
}
