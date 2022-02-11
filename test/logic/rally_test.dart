import 'package:test/test.dart';

import 'package:adriana/logic/match.dart';
import 'package:adriana/logic/rally.dart';

void main() {
  group('newRallyEvent()', () {
    group('Given a Match', () {
      final now = DateTime.now();
      final match = newMatch(
        createdAt: now,
        p1: 'P1',
        p2: 'P2',
        surface: 'Indoors - Clay',
        venue: 'Tennis Court',
      );
      group('When p1 commits a fault', () {
        match['events'] = [
          {
            'event': 'Score',
            'server': 'p1',
          }
        ];
        final newRally = newRallyEvent(
          createdAt: now,
          match: match,
          player: 'p1',
          shot: 'SV',
          direction: 'CC',
          depth: 'N',
        );
        test('Then there is no winner in this point yet', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'SV',
            'direction': 'CC',
            'depth': 'N',
            'winner': null,
          });
        });
      });

      group('When p1 commits a double fault', () {
        match['events'] = [
          {
            'event': 'Score',
            'server': 'p1',
            'isServiceFault': true,
          }
        ];
        final newRally = newRallyEvent(
          createdAt: now,
          match: match,
          player: 'p1',
          shot: 'SV',
          direction: 'CC',
          depth: 'N',
        );
        test('Then P2 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'SV',
            'direction': 'CC',
            'depth': 'N',
            'winner': 'p2',
          });
        });
      });

      group('When P1 serves an ace', () {
        match['events'] = [
          {
            'event': 'Score',
            'server': 'p1',
          }
        ];
        final newRally = newRallyEvent(
          createdAt: now,
          match: match,
          player: 'p1',
          shot: 'SV',
          direction: 'CC',
          depth: 'I',
        );
        test('Then P1 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'SV',
            'direction': 'CC',
            'depth': 'I',
            'winner': 'p1',
          });
        });
      });

      group('When P1 ball lands into the net', () {
        match['events'] = [
          {
            'event': 'Score',
            'server': 'p1',
          }
        ];
        final newRally = newRallyEvent(
          createdAt: now,
          match: match,
          player: 'p1',
          shot: 'FH',
          direction: 'CC',
          depth: 'N', // into the net
        );
        test('Then P2 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'FH',
            'direction': 'CC',
            'depth': 'N',
            'winner': 'p2',
          });
        });
      });

      group('When P1 ball lands out', () {
        match['events'] = [
          {
            'event': 'Score',
            'server': 'p1',
          }
        ];
        final newRally = newRallyEvent(
          createdAt: now,
          match: match,
          player: 'p1',
          shot: 'FH',
          direction: 'CC',
          depth: 'O',
        );
        test('Then P2 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'FH',
            'direction': 'CC',
            'depth': 'O',
            'winner': 'p2',
          });
        });
      });

      group('When P1 ball lands in', () {
        match['events'] = [
          {
            'event': 'Score',
            'server': 'p1',
          }
        ];
        final newRally = newRallyEvent(
          createdAt: now,
          match: match,
          player: 'p1',
          shot: 'SM', // smash
          direction: 'CC',
          depth: 'I', // in - winner
        );
        test('Then P1 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'SM',
            'direction': 'CC',
            'depth': 'I',
            'winner': 'p1',
          });
        });
      });
    });
  });

  group('whatWasTheShotHitOptions()', () {
    group('Given a rally', () {
      group('When receiving', () {
        test('Then do not allow SERVE stroke', () {
          final result = whatWasTheShotHitOptions(isServing: false);
          expect(
              result,
              containsPair('options', [
                {'label': 'BACKHAND', 'value': 'BH'},
                {'label': 'SMASH', 'value': 'SM'},
                {'label': 'VOLLEY', 'value': 'V'},
                {'label': 'FOREHAND', 'value': 'FH'},
              ]));
        });
      });
      group('When serving', () {
        final result = whatWasTheShotHitOptions(isServing: true);
        test('Then it is possible to choose SERVICE', () {
          expect(
              result,
              containsPair('options', [
                {'label': 'BACKHAND', 'value': 'BH'},
                {'label': 'SMASH', 'value': 'SM'},
                {'label': 'SERVE', 'value': 'SV'},
                {'label': 'VOLLEY', 'value': 'V'},
                {'label': 'FOREHAND', 'value': 'FH'},
              ]));
        });
      });
    });
  });

  group('whereDidTheBallLand()', () {
    group('Given a rally', () {
      group('When there is no direction defined', () {
        test('Then return rally options', () {
          expect(
              whereDidTheBallLandOptions(shot: ''),
              containsPair('options', [
                {'label': 'INTO THE NET', 'value': 'N'},
                {'label': 'WINNER', 'value': 'I'},
                {'label': 'OUT', 'value': 'O'}
              ]));
        });
      });
      group('When shot is SV', () {
        test('Then return server options', () {
          expect(
              whereDidTheBallLandOptions(shot: 'SV'),
              containsPair('options', [
                {'label': 'INTO THE NET', 'value': 'N'},
                {'label': 'ACE', 'value': 'I'},
                {'label': 'OUT', 'value': 'O'}
              ]));
        });
      });
      group('When shot is a FH', () {
        test('Then return options for rally', () {
          expect(
              whereDidTheBallLandOptions(shot: 'FH'),
              containsPair('options', [
                {'label': 'INTO THE NET', 'value': 'N'},
                {'label': 'WINNER', 'value': 'I'},
                {'label': 'OUT', 'value': 'O'}
              ]));
        });
      });
    });
  });
}
