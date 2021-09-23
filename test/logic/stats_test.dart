import 'package:test/test.dart';

import 'package:adriana/logic/stats.dart';

void main() {
  group('decidingPoints()', () {
    group('Given no events', () {
      final events = <Map>[];
      test('Then returns a zeroed stats', () {
        expect(decidingPoints(events: events), {
          'points': 0,
          'p1': {
            'points': 0,
            'service': {
              'points': 0,
              'faults': 0,
              'double-fault': 0,
              'ace': 0,
              'shots': 0,
              'into-the-net': 0,
              'out': 0,
              'in': 0
            },
            'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
            'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
            'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
            'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
          },
          'p2': {
            'points': 0,
            'service': {
              'points': 0,
              'faults': 0,
              'double-fault': 0,
              'ace': 0,
              'shots': 0,
              'into-the-net': 0,
              'out': 0,
              'in': 0
            },
            'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
            'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
            'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
            'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
          }
        });
      });
    });
    group('Given a single rally', () {
      group('When p1 serving an ace', () {
        final events = [
          {
            'type': 'Rally',
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'SV',
            'depth': 'I',
            'winner': 'p1'
          }
        ];
        test('Then increment p1 stats', () {
          expect(decidingPoints(events: events), {
            'points': 1,
            'p1': {
              'points': 1,
              'service': {
                'points': 1,
                'faults': 0,
                'double-fault': 0,
                'ace': 1,
                'shots': 1,
                'into-the-net': 0,
                'out': 0,
                'in': 1
              },
              'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
              'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
            },
            'p2': {
              'points': 0,
              'service': {
                'points': 0,
                'faults': 0,
                'double-fault': 0,
                'ace': 0,
                'shots': 0,
                'into-the-net': 0,
                'out': 0,
                'in': 0
              },
              'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
              'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
            }
          });
        });
      });
      group('When p1 serving fault into the net', () {
        final events = [
          {
            'type': 'Rally',
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'SV',
            'depth': 'N',
            'winner': null
          }
        ];
        test('Then change p1 stats', () {
          expect(decidingPoints(events: events), {
            'points': 0,
            'p1': {
              'points': 0,
              'service': {
                'points': 0,
                'faults': 1,
                'double-fault': 0,
                'ace': 0,
                'shots': 1,
                'into-the-net': 1,
                'out': 0,
                'in': 0,
              },
              'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
              'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
            },
            'p2': {
              'points': 0,
              'service': {
                'points': 0,
                'faults': 0,
                'double-fault': 0,
                'ace': 0,
                'shots': 0,
                'into-the-net': 0,
                'out': 0,
                'in': 0,
              },
              'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
              'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
            }
          });
        });
      });
      group('When p1 serving fault out service box', () {
        final events = [
          {
            'type': 'Rally',
            'server': 'p1',
            'lastHitBy': 'p1',
            'shot': 'SV',
            'depth': 'O',
            'winner': null
          }
        ];
        test('Then change p1 stats', () {
          expect(decidingPoints(events: events), {
            'points': 0,
            'p1': {
              'points': 0,
              'service': {
                'points': 0,
                'faults': 1,
                'double-fault': 0,
                'ace': 0,
                'shots': 1,
                'into-the-net': 0,
                'out': 1,
                'in': 0,
              },
              'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
              'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
            },
            'p2': {
              'points': 0,
              'service': {
                'points': 0,
                'faults': 0,
                'double-fault': 0,
                'ace': 0,
                'shots': 0,
                'into-the-net': 0,
                'out': 0,
                'in': 0,
              },
              'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
              'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
            }
          });
        });
      });
    });
  });
}
