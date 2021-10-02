import 'package:test/test.dart';

import 'package:adriana/logic/score.dart';
import 'package:adriana/logic/match.dart';
import 'package:adriana/logic/coin_toss.dart';

void main() {
  group('formatStatsSet()', () {
    group('Given a score with 5 sets', () {
      final score = {
        'event': 'Score',
        'createdAt': DateTime.parse('2021-09-26 13:57:42.568975'),
        'pointNumber': 238,
        'p1': [
          {'game': '0', 'tiebreak': null, 'set': 6},
          {'game': '0', 'tiebreak': null, 'set': 6},
          {'game': '0', 'tiebreak': null, 'set': 2},
          {'game': '0', 'tiebreak': null, 'set': 3},
          {'game': '0', 'tiebreak': null, 'set': 0}
        ],
        'p2': [
          {'game': '0', 'tiebreak': null, 'set': 2},
          {'game': '0', 'tiebreak': null, 'set': 2},
          {'game': '0', 'tiebreak': null, 'set': 6},
          {'game': '0', 'tiebreak': null, 'set': 6},
          {'game': '0', 'tiebreak': null, 'set': 0}
        ],
        'state': 'first service, André',
        'server': 'p1',
        'isServiceFault': false,
        'courtSide': 'deuce'
      };
      test('Then formats the score correctly', () {
        expect(formatStatsSet('P1', 'P2', score), 'P2 6-3');
      });
    });
  });

  group('newScoreFromRally()', () {
    final now = DateTime.now();
    group('Given a Match', () {
      final match = newMatch(
          createdAt: DateTime.now(),
          p1: 'P1',
          p2: 'P2',
          surface: 'Indoors - Clay',
          venue: 'Academia Winners');
      group('When P1 is serving and commits a fault', () {
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
          'shot': 'SV',
          'depth': 'N',
          'winner': null,
        };
        test('Then doesnt count as a point', () {
          final newScore =
              newScoreFromRally(DateTime.now(), match, previousScore, rally);
          expect(
              newScore,
              allOf([
                containsPair('isServiceFault', true),
                containsPair('state', 'second service, P1'),
                containsPair('pointNumber', 1),
                containsPair('courtSide', 'deuce'),
              ]));
        });
      });
      group('When p1 is serving and commits a double fault', () {
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P1'
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
          'state': 'first service, P1'
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
            'state': 'first service, P2'
          });
        });
      });
      group('When p1 is serving and closes the sixth game in a row', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 23,
          'isServiceFault': false,
          'p1': [
            {'game': '40', 'tiebreak': null, 'set': 5}
          ],
          'p2': [
            {'game': '0', 'tiebreak': null, 'set': 0}
          ],
          'createdAt': now,
          'state': 'first service, P1'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p1 wins the set', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 24,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': null, 'set': 6},
              {'game': '0', 'tiebreak': null, 'set': 0},
            ],
            'p2': [
              {'game': '0', 'tiebreak': null, 'set': 0},
              {'game': '0', 'tiebreak': null, 'set': 0},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When the match is 5 games all and p1 wins another game', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 41,
          'isServiceFault': false,
          'p1': [
            {'game': '40', 'tiebreak': null, 'set': 5}
          ],
          'p2': [
            {'game': '0', 'tiebreak': null, 'set': 5}
          ],
          'createdAt': now,
          'state': 'first service, P1'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then the set goes up to 7 games', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 42,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': null, 'set': 6},
            ],
            'p2': [
              {'game': '0', 'tiebreak': null, 'set': 5},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When p1 leads the set by 6-5 and wins another game', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 48,
          'isServiceFault': false,
          'p1': [
            {'game': '40', 'tiebreak': null, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': null, 'set': 5}
          ],
          'createdAt': now,
          'state': 'first service, P1'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p1 wins the set', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 49,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': null, 'set': 7},
              {'game': '0', 'tiebreak': null, 'set': 0},
            ],
            'p2': [
              {'game': '0', 'tiebreak': null, 'set': 5},
              {'game': '0', 'tiebreak': null, 'set': 0},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When p1 leads by 6-5 but p2 even the set in 6-6', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 56,
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': null, 'set': 6}
          ],
          'p2': [
            {'game': '40', 'tiebreak': null, 'set': 5}
          ],
          'createdAt': now,
          'state': 'first service, P1'
        };
        final rally = {
          'winner': 'p2',
        };
        test('Then a tiebreak must be played', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 57,
            'isServiceFault': false,
            'tiebreakPointNumber': 1,
            'tiebreakServer': 'p2',
            'p1': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
            ],
            'p2': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When start the tiebreak and p1 win the point', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'deuce',
          'pointNumber': 60,
          'tiebreakPointNumber': 1,
          'tiebreakServer': 'p2',
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 0, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 0, 'set': 6}
          ],
          'createdAt': now,
          'state': 'first service, P1'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p2 is going to serve', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'ad',
            'pointNumber': 61,
            'tiebreakPointNumber': 2,
            'tiebreakServer': 'p2',
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 1, 'set': 6}
            ],
            'p2': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When p2 is serving and looses the second point of the tiebreak',
          () {
        final previousScore = {
          'event': 'Score',
          'server': 'p2',
          'courtSide': 'ad',
          'pointNumber': 61,
          'tiebreakPointNumber': 2,
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 1, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 0, 'set': 6}
          ],
          'createdAt': now,
          'state': 'first service, P2'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p2 will serve the second serve', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 62,
            'tiebreakPointNumber': 3,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 2, 'set': 6}
            ],
            'p2': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When p2 is serving and looses the third point of the tiebreak',
          () {
        final previousScore = {
          'event': 'Score',
          'server': 'p2',
          'courtSide': 'deuce',
          'pointNumber': 62,
          'tiebreakPointNumber': 3,
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 2, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 0, 'set': 6}
          ],
          'createdAt': now,
          'state': 'first service, P2'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p1 will serve the fourth point of the tiebreak', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'ad',
            'pointNumber': 63,
            'tiebreakPointNumber': 4,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 3, 'set': 6}
            ],
            'p2': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
            ],
            'createdAt': now,
            'state': 'first service, P1'
          });
        });
      });
      group('When p1 is serving and wins the fourth point of the tiebreak', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'ad',
          'pointNumber': 63,
          'tiebreakPointNumber': 4,
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 3, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 0, 'set': 6},
          ],
          'createdAt': now,
          'state': 'first service, P1'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p1 will serve the fifth point of the tiebreak', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p1',
            'courtSide': 'deuce',
            'pointNumber': 64,
            'tiebreakPointNumber': 5,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 4, 'set': 6}
            ],
            'p2': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
            ],
            'createdAt': now,
            'state': 'first service, P1'
          });
        });
      });
      group('When p1 is serving and wins the fifth point of the tiebreak', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p1',
          'courtSide': 'deuce',
          'pointNumber': 64,
          'tiebreakPointNumber': 5,
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 4, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 0, 'set': 6},
          ],
          'createdAt': now,
          'state': 'first service, P1'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p2 will serve the sixth point of the tiebreak', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'ad',
            'pointNumber': 65,
            'tiebreakPointNumber': 6,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 5, 'set': 6}
            ],
            'p2': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When p2 is serving and looses the sixth point of the tiebreak',
          () {
        final previousScore = {
          'event': 'Score',
          'server': 'p2',
          'courtSide': 'ad',
          'pointNumber': 65,
          'tiebreakPointNumber': 6,
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 5, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 0, 'set': 6},
          ],
          'createdAt': now,
          'state': 'first service, P2'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p2 will serve the seventh point of the tiebreak', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 66,
            'tiebreakPointNumber': 7,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 6, 'set': 6}
            ],
            'p2': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When p2 is serving and looses the seventh point of the tiebreak',
          () {
        final previousScore = {
          'event': 'Score',
          'server': 'p2',
          'courtSide': 'deuce',
          'pointNumber': 66,
          'tiebreakPointNumber': 7,
          'tiebreakServer': 'p1',
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 6, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 0, 'set': 6},
          ],
          'createdAt': now,
          'state': 'first service, P2'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p1 wins the tiebreak and P2 will start serving next set',
            () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 67,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 7, 'set': 7},
              {'game': '0', 'tiebreak': 0, 'set': 0},
            ],
            'p2': [
              {'game': '0', 'tiebreak': 0, 'set': 6},
              {'game': '0', 'tiebreak': 0, 'set': 0},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When p1 leads 6-5 tiebreak', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p2',
          'courtSide': 'deuce',
          'pointNumber': 66,
          'tiebreakPointNumber': 11,
          'tiebreakServer': 'p1',
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 6, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 5, 'set': 6},
          ],
          'createdAt': now,
          'state': 'first service, P2'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p1 wins the point and the tiebreak', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 67,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 7, 'set': 7},
              {'game': '0', 'tiebreak': 0, 'set': 0},
            ],
            'p2': [
              {'game': '0', 'tiebreak': 5, 'set': 6},
              {'game': '0', 'tiebreak': 0, 'set': 0},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
      group('When p1 leads 16-15 tiebreak', () {
        final previousScore = {
          'event': 'Score',
          'server': 'p2',
          'courtSide': 'deuce',
          'pointNumber': 66,
          'tiebreakPointNumber': 32,
          'tiebreakServer': 'p1',
          'isServiceFault': false,
          'p1': [
            {'game': '0', 'tiebreak': 16, 'set': 6}
          ],
          'p2': [
            {'game': '0', 'tiebreak': 15, 'set': 6},
          ],
          'createdAt': now,
          'state': 'first service, P2'
        };
        final rally = {
          'winner': 'p1',
        };
        test('Then p1 wins the point and the tiebreak', () {
          final newScore = newScoreFromRally(now, match, previousScore, rally);
          expect(newScore, {
            'event': 'Score',
            'server': 'p2',
            'courtSide': 'deuce',
            'pointNumber': 67,
            'isServiceFault': false,
            'p1': [
              {'game': '0', 'tiebreak': 17, 'set': 7},
              {'game': '0', 'tiebreak': 0, 'set': 0},
            ],
            'p2': [
              {'game': '0', 'tiebreak': 15, 'set': 6},
              {'game': '0', 'tiebreak': 0, 'set': 0},
            ],
            'createdAt': now,
            'state': 'first service, P2'
          });
        });
      });
    });
  });
  group('formatScore', () {
    group('Given a match', () {
      final match = newMatch(
          createdAt: DateTime.now(),
          p1: 'P1',
          p2: 'P2',
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
          expect(formatScore(match, score, 'p1'), 'P1 0/0 6-7(5)');
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
          expect(formatScore(match, score, 'p2'), 'P2 0/0 7-6(5)');
        });
      });
      group('When tie break on the 3th set', () {
        final score = {
          "event": "Score",
          "createdAt": "2021-09-24T10:35:51.262624",
          "pointNumber": 212,
          "p1": [
            {"game": "0", "tiebreak": null, "set": 3},
            {"game": "0", "tiebreak": null, "set": 3},
            {"game": "0", "tiebreak": 6, "set": 6}
          ],
          "p2": [
            {"game": "0", "tiebreak": null, "set": 6},
            {"game": "0", "tiebreak": null, "set": 6},
            {"game": "0", "tiebreak": 2, "set": 6}
          ],
          "state": "first service, P1",
          "server": "p1",
          "isServiceFault": false,
          "courtSide": "deuce",
          "tiebreakServer": "p1",
          "tiebreakPointNumber": 9
        };
        test('Then displays the tiebreak result in the score', () {
          expect(formatScore(match, score, 'p1'), 'P1 6/2 3-6 3-6 6-6');
        });
      });
    });
  });

  group('Given a Match', () {
    final match = newMatch(
        createdAt: DateTime.now(),
        p1: 'P1',
        p2: 'P2',
        surface: 'Hard',
        venue: 'US Open 2021');
    group('When it has just done the coin toss and P1 won it', () {
      final coinToss =
          newCoinTossEvent(createdAt: DateTime.now(), winner: 'p1');
      final newScore = newScoreFromCoinToss(match, coinToss);
      match['events'].add(coinToss);
      match['events'].add(newScore);
      test('Then the Score is zeroed, starting with P1', () {
        expect(formatScore(match, newScore, 'p1'), 'P1 0/0 0-0');
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
      test('Then P2 leads fourty fifteen', () {
        expect(formatScore(match, score, 'p2'), 'P2 40/15 0-0');
      });
    });
    group('When P2 leads the second set', () {
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
        expect(formatScore(match, score, 'p2'), 'P2 40/30 4-6 5-3');
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
