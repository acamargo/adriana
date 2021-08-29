import 'package:test/test.dart';

import 'package:adriana/logic/coin_toss.dart';

void main() {
  group('Given a new match', () {
    final firstScore = {'event': 'Score'};
    final match = {
      'p1': 'Nadal',
      'p2': 'Federer',
      'events': [firstScore],
    };
    group('When a coin toss occurs', () {
      final coinToss = {'server': 'p1'};

      test('Then a new Score is defined with the server', () {
        final newScore = buildScoreFromCoinToss(match, coinToss);
        expect(
            newScore,
            allOf([
              containsPair('server', 'p1'),
              containsPair('isServiceFault', false),
              containsPair('courtSide', 'deuce'),
              containsPair('state', 'first service, Nadal')
            ]));
      });
    });
  });
}
