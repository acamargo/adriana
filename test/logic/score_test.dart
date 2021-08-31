import 'package:test/test.dart';

import 'package:adriana/logic/score.dart';
import 'package:adriana/logic/match.dart';
import 'package:adriana/logic/coin_toss.dart';

void main() {
  group('newScoreFromRally()', () {
    final now = DateTime.now();
    group('Given a Match', () {
      final match = newMatch(
          createdAt: DateTime.now(),
          p1: 'André',
          p2: 'Angelo',
          surface: 'Indoors - Clay',
          venue: 'Academia Winners');
      group('When André is serving and commits a fault', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'deuce',
          'pointNumber': 1,
          'p1': [
            {'game': '0', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '0', 'tiebreak': null, 'set': 0}
          ],
        };
        final rally = {
          'shot': 'F',
          'winner': null,
        };
        test('Then doesnt count as a point', () {
          final newScore =
              newScoreFromRally(DateTime.now(), match, previousScore, rally);
          expect(
              newScore,
              allOf([
                containsPair('isServiceFault', true),
                containsPair('state', 'second service, André'),
                containsPair('pointNumber', 1),
                containsPair('courtSide', 'deuce'),
              ]));
        });
      });
      group('When André is serving and commits a double fault', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'deuce',
          'pointNumber': 1,
          'isServiceFault': true,
          'p1': [
            {'game': '0', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '0', 'tiebreak': null, 'set': 0}
          ],
        };
        final rally = {
          'shot': 'DF',
          'winner': 'p2',
        };
        test('Then count as point to p2', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'ad',
            'pointNumber': 2,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '15', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group('When p1 is serving and commits an ace', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 2,
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '15', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'shot': 'A',
          'winner': 'p1',
        };
        test('Then count as point to p1', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'deuce',
            'pointNumber': 3,
            'isServiceFault': false,
            'p1': [
              {'game': '15', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '15', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group(
          'When p1 is serving and wins the point with a groundstroke forehand winner',
          () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'deuce',
          'pointNumber': 3,
          'isServiceFault': false,
          'p1': [
            {'game': '15', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '15', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'shot': 'GF',
          'winner': 'p1',
        };
        test('Then count as point to p1', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'ad',
            'pointNumber': 4,
            'isServiceFault': false,
            'p1': [
              {'game': '30', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '15', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group(
          'When p1 is serving and wins the point with a groundstroke backhand winner',
          () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 4,
          'isServiceFault': false,
          'p1': [
            {'game': '30', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '15', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then count as point to p1', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'deuce',
            'pointNumber': 5,
            'isServiceFault': false,
            'p1': [
              {'game': '40', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '15', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group('When p1 is serving and miss a backhand volley', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'deuce',
          'pointNumber': 5,
          'isServiceFault': false,
          'p1': [
            {'game': '40', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '15', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'winner': 'p2',
        };
        test('Then count as point to p2', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'ad',
            'pointNumber': 6,
            'isServiceFault': false,
            'p1': [
              {'game': '40', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '30', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group('When p1 is serving and miss a smash', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 6,
          'isServiceFault': false,
          'p1': [
            {'game': '40', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '30', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'winner': 'p2',
        };
        test('Then count as point to p2', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'deuce',
            'pointNumber': 7,
            'isServiceFault': false,
            'p1': [
              {'game': '40', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '40', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group('When p1 is serving and miss a forehand volley', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'deuce',
          'pointNumber': 7,
          'isServiceFault': false,
          'p1': [
            {'game': '40', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '40', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'winner': 'p2',
        };
        test('Then count as advantage to p2', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'ad',
            'pointNumber': 8,
            'isServiceFault': false,
            'p1': [
              {'game': '40', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': 'Ad', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group('When p1 is serving and p2 plays a forehand into the net', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 8,
          'isServiceFault': false,
          'p1': [
            {'game': '40', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': 'Ad', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then the score is deuce', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'deuce',
            'pointNumber': 9,
            'isServiceFault': false,
            'p1': [
              {'game': '40', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '40', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group('When p1 is serving and hits a forehand volley winner', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'deuce',
          'pointNumber': 10,
          'isServiceFault': false,
          'p1': [
            {'game': '40', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '40', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then is advantage to p1', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'ad',
            'pointNumber': 11,
            'isServiceFault': false,
            'p1': [
              {'game': 'Ad', 'tiebreak': null, 'set': 0}
            ],
            'p2': [
              {'game': '40', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, André'
          });
        });
      });
      group('When p1 is serving and hits an ace', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 11,
          'isServiceFault': false,
          'p1': [
            {'game': 'Ad', 'tiebreak': null, 'set': 0}
          ],
          'p2': [
            {'game': '40', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, André'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p1 wins the game', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 12,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': null, 'set': 1}
            ],
            'p2': [
              {'game': '0', 'tiebreak': null, 'set': 0}
            ],
            'createdAt': now,
            'state': 'first service, Angelo'
          });
        });
      });
    });
  });
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
