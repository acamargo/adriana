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
  group('whatWasTheShotHitOptions()', () {
    group('Given a rally', () {
      group('When it is receiving', () {
        test('Then returns only shots possible for receiver', () {
          final result = whatWasTheShotHitOptions(
              consistency: '1', isServing: false, isServiceFault: false);
          expect(result, containsPair('label', 'What was the shot hit?'));
          expect(
              result,
              containsPair('options', [
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'groundstroke backhand', 'value': 'GBH'},
                {'label': 'volley forehand', 'value': 'VFH'},
                {'label': 'volley backhand', 'value': 'VBH'},
                {'label': 'smash', 'value': 'SH'},
                {'label': 'lob', 'value': 'L'},
                {'label': 'passing shot forehand', 'value': 'PSFH'},
                {'label': 'passing shot backhand', 'value': 'PSBH'},
                {'label': 'tweeter', 'value': 'TW'},
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'drop shot forehand', 'value': 'DSFH'},
                {'label': 'drop shot backhand', 'value': 'DSBH'},
                {'label': 'half-volley forehand', 'value': 'HVFH'},
                {'label': 'half-volley backhand', 'value': 'HVBH'}
              ]));
        });
      });
      group('When first service and the rally length was 1', () {
        test('Then it is possible the receiver shots plus ace and fault', () {
          final result = whatWasTheShotHitOptions(
              consistency: '1', isServing: true, isServiceFault: false);
          expect(result, containsPair('label', 'What was the shot hit?'));
          expect(
              result,
              containsPair('options', [
                {'label': 'ace', 'value': 'A'},
                {'label': 'fault', 'value': 'F'},
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'groundstroke backhand', 'value': 'GBH'},
                {'label': 'volley forehand', 'value': 'VFH'},
                {'label': 'volley backhand', 'value': 'VBH'},
                {'label': 'smash', 'value': 'SH'},
                {'label': 'lob', 'value': 'L'},
                {'label': 'passing shot forehand', 'value': 'PSFH'},
                {'label': 'passing shot backhand', 'value': 'PSBH'},
                {'label': 'tweeter', 'value': 'TW'},
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'drop shot forehand', 'value': 'DSFH'},
                {'label': 'drop shot backhand', 'value': 'DSBH'},
                {'label': 'half-volley forehand', 'value': 'HVFH'},
                {'label': 'half-volley backhand', 'value': 'HVBH'}
              ]));
        });
      });
      group('When first service and the rally length was 3', () {
        test('Then it is possible the receiver shots', () {
          final result = whatWasTheShotHitOptions(
              consistency: '3', isServing: true, isServiceFault: false);
          expect(result, containsPair('label', 'What was the shot hit?'));
          expect(
              result,
              containsPair('options', [
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'groundstroke backhand', 'value': 'GBH'},
                {'label': 'volley forehand', 'value': 'VFH'},
                {'label': 'volley backhand', 'value': 'VBH'},
                {'label': 'smash', 'value': 'SH'},
                {'label': 'lob', 'value': 'L'},
                {'label': 'passing shot forehand', 'value': 'PSFH'},
                {'label': 'passing shot backhand', 'value': 'PSBH'},
                {'label': 'tweeter', 'value': 'TW'},
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'drop shot forehand', 'value': 'DSFH'},
                {'label': 'drop shot backhand', 'value': 'DSBH'},
                {'label': 'half-volley forehand', 'value': 'HVFH'},
                {'label': 'half-volley backhand', 'value': 'HVBH'}
              ]));
        });
      });
      group('When second serve and the rally length was 1', () {
        test('Then it is possible the receiver shots plus double fault', () {
          final result = whatWasTheShotHitOptions(
              consistency: '1', isServing: true, isServiceFault: true);
          expect(result, containsPair('label', 'What was the shot hit?'));
          expect(
              result,
              containsPair('options', [
                {'label': 'ace', 'value': 'A'},
                {'label': 'double fault', 'value': 'DF'},
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'groundstroke backhand', 'value': 'GBH'},
                {'label': 'volley forehand', 'value': 'VFH'},
                {'label': 'volley backhand', 'value': 'VBH'},
                {'label': 'smash', 'value': 'SH'},
                {'label': 'lob', 'value': 'L'},
                {'label': 'passing shot forehand', 'value': 'PSFH'},
                {'label': 'passing shot backhand', 'value': 'PSBH'},
                {'label': 'tweeter', 'value': 'TW'},
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'drop shot forehand', 'value': 'DSFH'},
                {'label': 'drop shot backhand', 'value': 'DSBH'},
                {'label': 'half-volley forehand', 'value': 'HVFH'},
                {'label': 'half-volley backhand', 'value': 'HVBH'}
              ]));
        });
      });
      group('When second serve and the rally length was 3', () {
        final result = whatWasTheShotHitOptions(
            consistency: '3', isServing: true, isServiceFault: true);
        test('Then it is possible the receiver shots', () {
          expect(result, containsPair('label', 'What was the shot hit?'));
          expect(
              result,
              containsPair('options', [
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'groundstroke backhand', 'value': 'GBH'},
                {'label': 'volley forehand', 'value': 'VFH'},
                {'label': 'volley backhand', 'value': 'VBH'},
                {'label': 'smash', 'value': 'SH'},
                {'label': 'lob', 'value': 'L'},
                {'label': 'passing shot forehand', 'value': 'PSFH'},
                {'label': 'passing shot backhand', 'value': 'PSBH'},
                {'label': 'tweeter', 'value': 'TW'},
                {'label': 'groundstroke forehand', 'value': 'GFH'},
                {'label': 'drop shot forehand', 'value': 'DSFH'},
                {'label': 'drop shot backhand', 'value': 'DSBH'},
                {'label': 'half-volley forehand', 'value': 'HVFH'},
                {'label': 'half-volley backhand', 'value': 'HVBH'}
              ]));
        });
      });
    });
  });

  group('whatWasTheBallDirectionOptions()', () {
    group('Given a rally', () {
      group('When there is no shot defined', () {
        test('Then return no options', () {
          expect(
              whatWasTheBallDirectionOptions(
                  shot: '', isServiceStroke: false, whoIsReceiving: 'P1 name'),
              allOf(containsPair('label', 'What was the ball direction?'),
                  containsPair('options', [])));
        });
      });
      group('When there is a shot and isServiceStroke true', () {
        test('Then the options are for server', () {
          expect(
              whatWasTheBallDirectionOptions(
                  shot: 'A', isServiceStroke: true, whoIsReceiving: 'P1 name'),
              allOf(
                  containsPair('label', 'What was the ball direction?'),
                  containsPair('options', [
                    {'label': "P1 name's forehand", 'value': 'FH'},
                    {'label': "P1 name's body", 'value': 'B'},
                    {'label': "P1 name's backhand", 'value': 'BH'},
                    {'label': 'wide', 'value': 'W'}
                  ])));
        });
      });
      group('When there is a shot and isServiceStroke false', () {
        test('Then the options are for receiver', () {
          expect(
              whatWasTheBallDirectionOptions(
                  shot: 'A', isServiceStroke: false, whoIsReceiving: 'P1 name'),
              allOf(
                  containsPair('label', 'What was the ball direction?'),
                  containsPair('options', [
                    {'label': 'cross-court', 'value': 'CC'},
                    {'label': 'middle-court', 'value': 'MD'},
                    {'label': 'down-the-line', 'value': 'DL'}
                  ])));
        });
      });
    });
  });

  group('whereDidTheBallLand()', () {
    group('Given a rally', () {
      group('When there is no direction defined', () {
        test('Then return no options', () {
          expect(
              whereDidTheBallLandOptions(direction: '', shot: ''),
              allOf(containsPair('label', 'Where did the ball land?'),
                  containsPair('options', [])));
        });
      });
      group('When there is direction and shot is ace', () {
        test('Then return server options', () {
          expect(
              whereDidTheBallLandOptions(direction: 'B', shot: 'A'),
              allOf(
                  containsPair('label', 'Where did the ball land?'),
                  containsPair('options', [
                    {'label': 'short', 'value': 'S'},
                    {'label': 'deep', 'value': 'D'},
                  ])));
        });
      });
      group('When there is direction and shot is fault', () {
        test('Then return server options for error', () {
          expect(
              whereDidTheBallLandOptions(direction: 'B', shot: 'F'),
              allOf(
                  containsPair('label', 'Where did the ball land?'),
                  containsPair('options', [
                    {'label': 'into the net', 'value': 'N'},
                    {'label': 'long', 'value': 'L'},
                    {'label': 'wide', 'value': 'W'},
                  ])));
        });
      });
      group('When there is direction and shot is double fault', () {
        test('Then return server options for error', () {
          expect(
              whereDidTheBallLandOptions(direction: 'B', shot: 'DF'),
              allOf(
                  containsPair('label', 'Where did the ball land?'),
                  containsPair('options', [
                    {'label': 'into the net', 'value': 'N'},
                    {'label': 'long', 'value': 'L'},
                    {'label': 'wide', 'value': 'W'},
                  ])));
        });
      });
      group('When there is direction and shot is groundstroke forehand', () {
        test('Then all options are available', () {
          expect(
              whereDidTheBallLandOptions(direction: 'CC', shot: 'GFH'),
              allOf(
                  containsPair('label', 'Where did the ball land?'),
                  containsPair('options', [
                    {'label': 'into the net', 'value': 'N'},
                    {'label': 'long', 'value': 'L'},
                    {'label': 'wide', 'value': 'W'},
                    {'label': 'short', 'value': 'S'},
                    {'label': 'deep', 'value': 'D'},
                  ])));
        });
      });
    });
  });
}
