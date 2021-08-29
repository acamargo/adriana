import 'package:test/test.dart';

import 'package:adriana/logic/score.dart';
import 'package:adriana/logic/match.dart';
import 'package:adriana/logic/coin_toss.dart';

void main() {
  group('Given a Match', () {
    final match = newMatch(
        createdAt: DateTime.now(),
        p1: 'Isner',
        p2: 'Opelka',
        surface: 'Hard',
        venue: 'US Open 2021');
    group('When it has just done the coin toss', () {
      final coinToss =
          newCoinTossEvent(createdAt: DateTime.now(), winner: 'p1');
      final newScore = newScoreFromCoinToss(match, coinToss);
      match['events'].add(coinToss);
      match['events'].add(newScore);
      test('Then the Score is zeroed', () {
        expect(formatScore(match, newScore), 'Isner 0/0 0-0');
      });
    });
  });
}
