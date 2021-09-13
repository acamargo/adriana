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
          consistency: '1',
          shot: 'F',
          direction: 'FH',
          depth: 'N',
        );
        test('Then there is no winner in this point yet', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'lastHitBy': 'p1',
            'consistency': '1',
            'shot': 'F',
            'direction': 'FH',
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
          }
        ];
        final newRally = newRallyEvent(
          createdAt: now,
          match: match,
          player: 'p1',
          consistency: '1',
          shot: 'DF',
          direction: 'FH',
          depth: 'N',
        );
        test('Then P2 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'lastHitBy': 'p1',
            'consistency': '1',
            'shot': 'DF',
            'direction': 'FH',
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
          consistency: '1',
          shot: 'A', // ace
          direction: 'FH', // forehand
          depth: 'S', // short
        );
        test('Then P1 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'lastHitBy': 'p1',
            'consistency': '1',
            'shot': 'A',
            'direction': 'FH',
            'depth': 'S',
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
          consistency: '3',
          shot: 'GFH', // groundstroke forehand
          direction: 'CC', // cross-court
          depth: 'N', // into the net
        );
        test('Then P2 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'lastHitBy': 'p1',
            'consistency': '3',
            'shot': 'GFH',
            'direction': 'CC',
            'depth': 'N',
            'winner': 'p2',
          });
        });
      });

      group('When P1 ball lands long', () {
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
          consistency: '3',
          shot: 'GBH', // groundstroke forehand
          direction: 'DL', // down-the-line
          depth: 'L', // long
        );
        test('Then P2 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'lastHitBy': 'p1',
            'consistency': '3',
            'shot': 'GBH',
            'direction': 'DL',
            'depth': 'L',
            'winner': 'p2',
          });
        });
      });

      group('When P1 ball lands wide', () {
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
          consistency: '3',
          shot: 'VFH', // volley forehand
          direction: 'DL', // down-the-line
          depth: 'W', // wide
        );
        test('Then P2 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'lastHitBy': 'p1',
            'consistency': '3',
            'shot': 'VFH',
            'direction': 'DL',
            'depth': 'W',
            'winner': 'p2',
          });
        });
      });

      group('When P1 ball lands short', () {
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
          consistency: '3',
          shot: 'VBH', // volley backhand
          direction: 'CC', // cross-court
          depth: 'S', // short
        );
        test('Then P1 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'lastHitBy': 'p1',
            'consistency': '3',
            'shot': 'VBH',
            'direction': 'CC',
            'depth': 'S',
            'winner': 'p1',
          });
        });
      });

      group('When P1 ball lands deep', () {
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
          consistency: '3',
          shot: 'SH', // smash
          direction: 'MD', // middle-court
          depth: 'D', // deep
        );
        test('Then P1 won the point', () {
          expect(newRally, {
            'event': 'Rally',
            'createdAt': now,
            'lastHitBy': 'p1',
            'consistency': '3',
            'shot': 'SH',
            'direction': 'MD',
            'depth': 'D',
            'winner': 'p1',
          });
        });
      });
    });
  });
  group('whatWasTheRallyLengthOptions()', () {
    group('Given a rally', () {
      group('When there is no player', () {
        test('Then return an empty list of options', () {
          expect(
              whatWasTheRallyLengthOptions(
                  player: '', consistency: '', isServing: true),
              {'label': 'What was the rally length?', 'options': []});
        });
      });
      group('When the player is serving and no consistency', () {
        test('Then return label and options for server', () {
          expect(
              whatWasTheRallyLengthOptions(
                  player: 'p1', consistency: '', isServing: true),
              {
                'label': 'What was the rally length?',
                'options': [
                  {'label': 'one shot', 'value': '1'},
                  {'label': 'three shots or more', 'value': '3'},
                ]
              });
        });
      });
      group('When the player is receiving and consistency is defined', () {
        test('Then return no label and options for receiver', () {
          expect(
              whatWasTheRallyLengthOptions(
                  player: 'p1', consistency: '1', isServing: false),
              {
                'label': 'What was the rally length?',
                'options': [
                  {'label': 'two shots', 'value': '2'},
                  {'label': 'four shots or more', 'value': '4'}
                ]
              });
        });
      });
    });
  });
}
