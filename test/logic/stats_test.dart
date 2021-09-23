import 'package:test/test.dart';

import 'package:adriana/logic/stats.dart';

void main() {
  group('playerParticipation()', () {
    group('Given no events', () {
      final events = <Map>[];
      test('Then returns a zeroed stats', () {
        expect(playerParticipation(events: events), {
          'points': 0,
          'p1': {
            'points': 0,
            'service': {'points': 0, 'double-fault': 0, 'ace': 0},
            'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
            'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
            'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
            'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
          },
          'p2': {
            'points': 0,
            'service': {'points': 0, 'double-fault': 0, 'ace': 0},
            'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
            'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
            'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
            'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
          }
        });
      });
    });
    group('Given a single rally', () {
      group('When p1 won the point', () {
        final events = [
          {
            'type': 'Rally',
            'lastHitBy': 'p1',
            'shot': 'SV',
            'depth': 'I',
            'winner': 'p1'
          }
        ];
        test('Then increment p1 stats', () {
          expect(playerParticipation(events: events), {
            'points': 1,
            'p1': {
              'points': 1,
              'service': {'points': 1, 'double-fault': 0, 'ace': 1},
              'forehand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'backhand': {'points': 0, 'double-fault': 0, 'ace': 0},
              'smash': {'points': 0, 'double-fault': 0, 'ace': 0},
              'volley': {'points': 0, 'double-fault': 0, 'ace': 0}
            },
            'p2': {
              'points': 0,
              'service': {'points': 0, 'double-fault': 0, 'ace': 0},
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
