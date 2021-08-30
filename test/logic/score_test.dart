import 'package:test/test.dart';

import 'package:adriana/logic/score.dart';
import 'package:adriana/logic/match.dart';
import 'package:adriana/logic/coin_toss.dart';

void main() {
  group('formatScore', () {
    group('Given a match', () {
      final match = newMatch(
          createdAt: DateTime.now(),
          p1: 'Isner',
          p2: 'Opelka',
          surface: 'Hard',
          venue: 'US Open 2021');
      group('When this is a tie break and p1 is serving', () {
        final score = {
          'event': 'Score',
          'server': 'p1',
          'p1': [
            {'game': '0', 'tiebreak': 5, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 7, 'set': 7}
          ],
        };
        test('Then displays the tiebreak result in the score', () {
          expect(formatScore(match, score), 'Isner 0/0 6-7(5)');
        });
      });
      group('When this is a tie break and p2 is serving', () {
        final score = {
          'event': 'Score',
          'server': 'p2',
          'p1': [
            {'game': '0', 'tiebreak': 5, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 7, 'set': 7}
          ],
        };
        test('Then displays the tiebreak result in the score', () {
          expect(formatScore(match, score), 'Opelka 0/0 7-6(5)');
        });
      });
    });
  });

  group('Given a Match', () {
    final match = newMatch(
        createdAt: DateTime.now(),
        p1: 'Isner',
        p2: 'Opelka',
        surface: 'Hard',
        venue: 'US Open 2021');
    group('When it has just done the coin toss and Isner won it', () {
      final coinToss =
          newCoinTossEvent(createdAt: DateTime.now(), winner: 'p1');
      final newScore = newScoreFromCoinToss(match, coinToss);
      match['events'].add(coinToss);
      match['events'].add(newScore);
      test('Then the Score is zeroed, starting with Isner', () {
        expect(formatScore(match, newScore), 'Isner 0/0 0-0');
      });
    });
    group('When a game in the first set is in progress', () {
      final score = {
        'event': 'Score',
        'server': 'p2',
        'p1': [
          {'game': '15', 'set': 0}
        ],
        'p2': [
          {'game': '40', 'set': 0}
        ],
      };
      test('Then Opelka leads fourty fifteen', () {
        expect(formatScore(match, score), 'Opelka 40/15 0-0');
      });
    });
    group('When Opelka leads the second set', () {
      final score = {
        'event': 'Score',
        'server': 'p2',
        'p1': [
          {'game': '0', 'set': 6},
          {'game': '30', 'set': 3}
        ],
        'p2': [
          {'game': '0', 'set': 4},
          {'game': '40', 'set': 5}
        ],
      };
      test('Then formats two sets accordingly', () {
        expect(formatScore(match, score), 'Opelka 40/30 4-6 5-3');
      });
    });
  });

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
        final newScore = newScoreFromCoinToss(match, coinToss);
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
