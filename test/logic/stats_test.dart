import 'dart:io';
import 'package:test/test.dart';

import 'package:adriana/logic/stats.dart';
import 'package:adriana/matches_storage.dart';

void main() {
  group('matchStats()', () {
    group('Given a 5 sets sample with empty fifth set', () {
      final file =
          new File('test_resources/2021-10-07T07:27:00.467303.match.json');
      test('Then generate the stats', () async {
        final MatchesStorage storage = MatchesStorage();
        final match = await storage.loadMatch(file);
        expect(matchStats(match: match), {
          'score': 'Ângelo 6-0 6-1 6-1 5-7',
          'match-duration': [
            Duration(hours: 1, minutes: 38, seconds: 32, microseconds: 154162),
            Duration(minutes: 19, seconds: 24, microseconds: 214000),
            Duration(minutes: 21, seconds: 23, microseconds: 724047),
            Duration(minutes: 18, seconds: 14, microseconds: 462279),
            Duration(minutes: 39, seconds: 29, microseconds: 753836)
          ],
          'match-time': [
            {
              'start': DateTime.parse('2021-10-07 07:27:00.467303'),
              'end': DateTime.parse('2021-10-07 07:27:00.467303')
            },
            {
              'start': DateTime.parse('2021-10-07 07:59:27.178893'),
              'end': DateTime.parse('2021-10-07 08:18:51.392893')
            },
            {
              'start': DateTime.parse('2021-10-07 08:19:16.925583'),
              'end': DateTime.parse('2021-10-07 08:40:40.649630')
            },
            {
              'start': DateTime.parse('2021-10-07 08:42:04.194297'),
              'end': DateTime.parse('2021-10-07 09:00:18.656576')
            },
            {
              'start': DateTime.parse('2021-10-07 09:01:15.994431'),
              'end': DateTime.parse('2021-10-07 09:40:45.748267')
            }
          ],
          'scores': [
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 09:40:45.748328'),
              'pointNumber': 210,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 5},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 0},
                {'game': '0', 'tiebreak': null, 'set': 1},
                {'game': '0', 'tiebreak': null, 'set': 1},
                {'game': '0', 'tiebreak': null, 'set': 7},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'state': 'first service, André',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce'
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 08:18:51.392950'),
              'pointNumber': 38,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 0},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'state': 'first service, André',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce'
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 08:40:40.649679'),
              'pointNumber': 83,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 0},
                {'game': '0', 'tiebreak': null, 'set': 1},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'state': 'first service, Ângelo',
              'server': 'p1',
              'isServiceFault': false,
              'courtSide': 'ad'
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 09:00:18.656617'),
              'pointNumber': 121,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 0},
                {'game': '0', 'tiebreak': null, 'set': 1},
                {'game': '0', 'tiebreak': null, 'set': 1},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'state': 'first service, André',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'ad'
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 09:40:45.748328'),
              'pointNumber': 210,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 5},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 0},
                {'game': '0', 'tiebreak': null, 'set': 1},
                {'game': '0', 'tiebreak': null, 'set': 1},
                {'game': '0', 'tiebreak': null, 'set': 7},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'state': 'first service, André',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce'
            }
          ],
          'p1': {
            'name': 'Ângelo',
            'results': [
              {
                'points-played': 210,
                'points-win': 127,
                'points-win-%': 60,
                'aces': 1,
                'double-faults': 9,
                '1st-serve-played': 65,
                '1st-serve-win': 40,
                '1st-serve-win-%': 62,
                '2nd-serve-played': 38,
                '2nd-serve-win': 24,
                '2nd-serve-win-%': 63,
                'break-points-played': 20,
                'break-points-win': 11,
                'break-points-win-%': 55,
                'game-points-played': 38,
                'game-points-win': 23,
                'game-points-win-%': 61
              },
              {
                'points-played': 38,
                'points-win': 26,
                'points-win-%': 68,
                'aces': 1,
                'double-faults': 0,
                '1st-serve-played': 14,
                '1st-serve-win': 9,
                '1st-serve-win-%': 64,
                '2nd-serve-played': 6,
                '2nd-serve-win': 4,
                '2nd-serve-win-%': 67,
                'break-points-played': 3,
                'break-points-win': 3,
                'break-points-win-%': 100,
                'game-points-played': 6,
                'game-points-win': 6,
                'game-points-win-%': 100
              },
              {
                'points-played': 45,
                'points-win': 30,
                'points-win-%': 67,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 10,
                '1st-serve-win': 8,
                '1st-serve-win-%': 80,
                '2nd-serve-played': 6,
                '2nd-serve-win': 4,
                '2nd-serve-win-%': 67,
                'break-points-played': 5,
                'break-points-win': 3,
                'break-points-win-%': 60,
                'game-points-played': 11,
                'game-points-win': 6,
                'game-points-win-%': 55
              },
              {
                'points-played': 38,
                'points-win': 27,
                'points-win-%': 71,
                'aces': 0,
                'double-faults': 1,
                '1st-serve-played': 11,
                '1st-serve-win': 9,
                '1st-serve-win-%': 82,
                '2nd-serve-played': 8,
                '2nd-serve-win': 7,
                '2nd-serve-win-%': 88,
                'break-points-played': 3,
                'break-points-win': 2,
                'break-points-win-%': 67,
                'game-points-played': 9,
                'game-points-win': 6,
                'game-points-win-%': 67
              },
              {
                'points-played': 89,
                'points-win': 44,
                'points-win-%': 49,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 30,
                '1st-serve-win': 14,
                '1st-serve-win-%': 47,
                '2nd-serve-played': 18,
                '2nd-serve-win': 9,
                '2nd-serve-win-%': 50,
                'break-points-played': 9,
                'break-points-win': 3,
                'break-points-win-%': 33,
                'game-points-played': 12,
                'game-points-win': 5,
                'game-points-win-%': 42
              }
            ]
          },
          'p2': {
            'name': 'André',
            'results': [
              {
                'points-played': 210,
                'points-win': 83,
                'points-win-%': 40,
                'aces': 0,
                'double-faults': 17,
                '1st-serve-played': 37,
                '1st-serve-win': 17,
                '1st-serve-win-%': 46,
                '2nd-serve-played': 70,
                '2nd-serve-win': 27,
                '2nd-serve-win-%': 39,
                'break-points-played': 14,
                'break-points-win': 4,
                'break-points-win-%': 29,
                'game-points-played': 26,
                'game-points-win': 9,
                'game-points-win-%': 35
              },
              {
                'points-played': 38,
                'points-win': 12,
                'points-win-%': 32,
                'aces': 0,
                'double-faults': 4,
                '1st-serve-played': 5,
                '1st-serve-win': 2,
                '1st-serve-win-%': 40,
                '2nd-serve-played': 13,
                '2nd-serve-win': 3,
                '2nd-serve-win-%': 23,
                'break-points-played': 2,
                'break-points-win': 0,
                'break-points-win-%': 0,
                'game-points-played': 5,
                'game-points-win': 0,
                'game-points-win-%': 0
              },
              {
                'points-played': 45,
                'points-win': 15,
                'points-win-%': 33,
                'aces': 0,
                'double-faults': 5,
                '1st-serve-played': 12,
                '1st-serve-win': 6,
                '1st-serve-win-%': 50,
                '2nd-serve-played': 17,
                '2nd-serve-win': 5,
                '2nd-serve-win-%': 29,
                'break-points-played': 0,
                'break-points-win': 0,
                'break-points-win-%': 0,
                'game-points-played': 3,
                'game-points-win': 1,
                'game-points-win-%': 33
              },
              {
                'points-played': 38,
                'points-win': 11,
                'points-win-%': 29,
                'aces': 0,
                'double-faults': 1,
                '1st-serve-played': 7,
                '1st-serve-win': 2,
                '1st-serve-win-%': 29,
                '2nd-serve-played': 12,
                '2nd-serve-win': 6,
                '2nd-serve-win-%': 50,
                'break-points-played': 0,
                'break-points-win': 0,
                'break-points-win-%': 0,
                'game-points-played': 1,
                'game-points-win': 1,
                'game-points-win-%': 100
              },
              {
                'points-played': 89,
                'points-win': 45,
                'points-win-%': 51,
                'aces': 0,
                'double-faults': 7,
                '1st-serve-played': 13,
                '1st-serve-win': 7,
                '1st-serve-win-%': 54,
                '2nd-serve-played': 28,
                '2nd-serve-win': 13,
                '2nd-serve-win-%': 46,
                'break-points-played': 12,
                'break-points-win': 4,
                'break-points-win-%': 33,
                'game-points-played': 17,
                'game-points-win': 7,
                'game-points-win-%': 41
              }
            ]
          }
        });
      });
    });

    group('Given a 5 sets sample data', () {
      final file =
          new File('test_resources/2021-09-26T09:46:41.089075.match.json');
      test('Then generate the stats', () async {
        final MatchesStorage storage = MatchesStorage();
        final match = await storage.loadMatch(file);
        expect(matchStats(match: match), {
          'score': 'André 6-2 6-2 2-6 3-6 3-1',
          'match-duration': [
            Duration(hours: 2, minutes: 5, seconds: 40, microseconds: 449736),
            Duration(minutes: 26, seconds: 54, microseconds: 179033),
            Duration(minutes: 29, seconds: 26, microseconds: 746133),
            Duration(minutes: 26, seconds: 36, microseconds: 043366),
            Duration(minutes: 28, seconds: 25, microseconds: 083896),
            Duration(minutes: 14, seconds: 18, microseconds: 397308)
          ],
          'match-time': [
            {
              'start': DateTime.parse('2021-09-26 09:46:41.089075'),
              'end': DateTime.parse('2021-09-26 09:46:41.089075')
            },
            {
              'start': DateTime.parse('2021-09-26 10:12:34.902676'),
              'end': DateTime.parse('2021-09-26 10:39:29.081709')
            },
            {
              'start': DateTime.parse('2021-09-26 10:39:49.111766'),
              'end': DateTime.parse('2021-09-26 11:09:15.857899')
            },
            {
              'start': DateTime.parse('2021-09-26 11:09:57.748813'),
              'end': DateTime.parse('2021-09-26 11:36:33.792179')
            },
            {
              'start': DateTime.parse('2021-09-26 13:13:57.077945'),
              'end': DateTime.parse('2021-09-26 13:42:22.161841')
            },
            {
              'start': DateTime.parse('2021-09-26 13:43:24.171621'),
              'end': DateTime.parse('2021-09-26 13:57:42.568929')
            }
          ],
          'scores': [
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 13:57:42.568975'),
              'pointNumber': 238,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 3},
                {'game': '0', 'tiebreak': null, 'set': 3}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 1}
              ],
              'state': 'first service, André',
              'server': 'p1',
              'isServiceFault': false,
              'courtSide': 'deuce'
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 10:39:29.081756'),
              'pointNumber': 51,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'state': 'first service, Ângelo',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'ad'
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 11:09:15.857956'),
              'pointNumber': 108,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'state': 'first service, Ângelo',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce'
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 11:36:33.792222'),
              'pointNumber': 156,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 0}
              ],
              'state': 'first service, Ângelo',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce'
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 13:42:22.161896'),
              'pointNumber': 208,
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
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 13:57:42.568975'),
              'pointNumber': 238,
              'p1': [
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 3},
                {'game': '0', 'tiebreak': null, 'set': 3}
              ],
              'p2': [
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 2},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 6},
                {'game': '0', 'tiebreak': null, 'set': 1}
              ],
              'state': 'first service, André',
              'server': 'p1',
              'isServiceFault': false,
              'courtSide': 'deuce'
            }
          ],
          'p1': {
            'name': 'André',
            'results': [
              {
                'points-played': 238,
                'points-win': 126,
                'points-win-%': 53,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 72,
                '1st-serve-win': 36,
                '1st-serve-win-%': 50,
                '2nd-serve-played': 38,
                '2nd-serve-win': 20,
                '2nd-serve-win-%': 53,
                'break-points-played': 17,
                'break-points-win': 11,
                'break-points-win-%': 65,
                'game-points-played': 34,
                'game-points-win': 20,
                'game-points-win-%': 59
              },
              {
                'points-played': 51,
                'points-win': 31,
                'points-win-%': 61,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 12,
                '1st-serve-win': 8,
                '1st-serve-win-%': 67,
                '2nd-serve-played': 12,
                '2nd-serve-win': 6,
                '2nd-serve-win-%': 50,
                'break-points-played': 5,
                'break-points-win': 3,
                'break-points-win-%': 60,
                'game-points-played': 10,
                'game-points-win': 6,
                'game-points-win-%': 60
              },
              {
                'points-played': 57,
                'points-win': 34,
                'points-win-%': 60,
                'aces': 0,
                'double-faults': 0,
                '1st-serve-played': 16,
                '1st-serve-win': 11,
                '1st-serve-win-%': 69,
                '2nd-serve-played': 7,
                '2nd-serve-win': 6,
                '2nd-serve-win-%': 86,
                'break-points-played': 5,
                'break-points-win': 2,
                'break-points-win-%': 40,
                'game-points-played': 11,
                'game-points-win': 6,
                'game-points-win-%': 55
              },
              {
                'points-played': 48,
                'points-win': 21,
                'points-win-%': 44,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 21,
                '1st-serve-win': 8,
                '1st-serve-win-%': 38,
                '2nd-serve-played': 6,
                '2nd-serve-win': 1,
                '2nd-serve-win-%': 17,
                'break-points-played': 2,
                'break-points-win': 2,
                'break-points-win-%': 100.0,
                'game-points-played': 3,
                'game-points-win': 2,
                'game-points-win-%': 67
              },
              {
                'points-played': 52,
                'points-win': 22,
                'points-win-%': 42,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 10,
                '1st-serve-win': 2,
                '1st-serve-win-%': 20.0,
                '2nd-serve-played': 11,
                '2nd-serve-win': 6,
                '2nd-serve-win-%': 55,
                'break-points-played': 2,
                'break-points-win': 2,
                'break-points-win-%': 100,
                'game-points-played': 3,
                'game-points-win': 3,
                'game-points-win-%': 100
              },
              {
                'points-played': 30,
                'points-win': 18,
                'points-win-%': 60,
                'aces': 0,
                'double-faults': 0,
                '1st-serve-played': 13,
                '1st-serve-win': 7,
                '1st-serve-win-%': 54,
                '2nd-serve-played': 2,
                '2nd-serve-win': 1,
                '2nd-serve-win-%': 50,
                'break-points-played': 3,
                'break-points-win': 2,
                'break-points-win-%': 67,
                'game-points-played': 7,
                'game-points-win': 3,
                'game-points-win-%': 43
              }
            ]
          },
          'p2': {
            'name': 'Ângelo',
            'results': [
              {
                'points-played': 238,
                'points-win': 112,
                'points-win-%': 47,
                'aces': 0,
                'double-faults': 25,
                '1st-serve-played': 65,
                '1st-serve-win': 37,
                '1st-serve-win-%': 57,
                '2nd-serve-played': 63,
                '2nd-serve-win': 21,
                '2nd-serve-win-%': 33,
                'break-points-played': 15,
                'break-points-win': 9,
                'break-points-win-%': 60,
                'game-points-played': 32,
                'game-points-win': 17,
                'game-points-win-%': 53
              },
              {
                'points-played': 51,
                'points-win': 20,
                'points-win-%': 39,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 14,
                '1st-serve-win': 7,
                '1st-serve-win-%': 50,
                '2nd-serve-played': 13,
                '2nd-serve-win': 3,
                '2nd-serve-win-%': 23,
                'break-points-played': 2,
                'break-points-win': 1,
                'break-points-win-%': 50,
                'game-points-played': 5,
                'game-points-win': 2,
                'game-points-win-%': 40
              },
              {
                'points-played': 57,
                'points-win': 23,
                'points-win-%': 40,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 20,
                '1st-serve-win': 11,
                '1st-serve-win-%': 55,
                '2nd-serve-played': 14,
                '2nd-serve-win': 6,
                '2nd-serve-win-%': 43,
                'break-points-played': 0,
                'break-points-win': 0,
                'break-points-win-%': 0.0,
                'game-points-played': 6,
                'game-points-win': 2,
                'game-points-win-%': 33
              },
              {
                'points-played': 48,
                'points-win': 27,
                'points-win-%': 56,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 12,
                '1st-serve-win': 6,
                '1st-serve-win-%': 50,
                '2nd-serve-played': 9,
                '2nd-serve-win': 3,
                '2nd-serve-win-%': 33,
                'break-points-played': 6,
                'break-points-win': 4,
                'break-points-win-%': 67,
                'game-points-played': 9,
                'game-points-win': 6,
                'game-points-win-%': 67
              },
              {
                'points-played': 52,
                'points-win': 30,
                'points-win-%': 58,
                'aces': 0,
                'double-faults': 9,
                '1st-serve-played': 11,
                '1st-serve-win': 10,
                '1st-serve-win-%': 91,
                '2nd-serve-played': 20,
                '2nd-serve-win': 7,
                '2nd-serve-win-%': 35,
                'break-points-played': 5,
                'break-points-win': 3,
                'break-points-win-%': 60,
                'game-points-played': 9,
                'game-points-win': 6,
                'game-points-win-%': 67
              },
              {
                'points-played': 30,
                'points-win': 12,
                'points-win-%': 40,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 8,
                '1st-serve-win': 3,
                '1st-serve-win-%': 38,
                '2nd-serve-played': 7,
                '2nd-serve-win': 2,
                '2nd-serve-win-%': 29,
                'break-points-played': 2,
                'break-points-win': 1,
                'break-points-win-%': 50,
                'game-points-played': 3,
                'game-points-win': 1,
                'game-points-win-%': 33
              }
            ]
          }
        });
      });
    });
  });

  group('wonLost()', () {
    group('Given a 3 set sample data', () {
      final file =
          new File('test_resources/2021-09-24-andre-angelo-pirituba.json');
      test('Then generate the stats', () async {
        final MatchesStorage storage = MatchesStorage();
        final match = await storage.loadMatch(file);
        List<Map<String, dynamic>> events =
            new List<Map<String, dynamic>>.from(match['events']);
        expect(wonLost(events: events), {
          'p1': {
            'match': {'played': 212, 'won': 98, 'lost': 114},
            'serving': {'played': 104, 'won': 50, 'lost': 54}
          },
          'p2': {
            'match': {'played': 212, 'won': 114, 'lost': 98},
            'serving': {'played': 108, 'won': 60, 'lost': 48}
          }
        });
      });
    });

    group('Given a 5 sets sample data', () {
      final file =
          new File('test_resources/2021-09-26T09:46:41.089075.match.json');
      test('Then generate the stats', () async {
        final MatchesStorage storage = MatchesStorage();
        final match = await storage.loadMatch(file);
        List<Map<String, dynamic>> events =
            new List<Map<String, dynamic>>.from(match['events']);
        expect(wonLost(events: events), {
          'p1': {
            'match': {'played': 238, 'won': 126, 'lost': 112},
            'serving': {'played': 110, 'won': 56, 'lost': 54}
          },
          'p2': {
            'match': {'played': 238, 'won': 112, 'lost': 126},
            'serving': {'played': 128, 'won': 58, 'lost': 70}
          }
        });
      });
    });
  });

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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given p1 serving fault out service box', () {
      final events = [
        {
          'event': 'Rally',
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given p1 serving fault into the net', () {
      final events = [
        {
          'event': 'Rally',
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given p1 hits an ace', () {
      final events = [
        {
          'event': 'Rally',
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given p1 double fault', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'SV',
          'depth': 'N',
          'winner': null
        },
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'SV',
          'depth': 'O',
          'winner': 'p2'
        },
      ];
      test('Then register 1 point and 2 shots', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
            'service': {
              'points': 1,
              'faults': 1,
              'double-fault': 1,
              'ace': 0,
              'shots': 2,
              'into-the-net': 1,
              'out': 1,
              'in': 0,
            },
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given p1 forehand into-the-net', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'FH',
          'depth': 'N',
          'winner': 'p2'
        }
      ];
      test('Then increment p1 forehand stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 1, 'into-the-net': 1, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
    group('Given p1 forehand out', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'FH',
          'depth': 'O',
          'winner': 'p2'
        }
      ];
      test('Then increment p1 forehand stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 1, 'into-the-net': 0, 'out': 1, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
    group('Given p1 forehand winner', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'FH',
          'depth': 'I',
          'winner': 'p1'
        }
      ];
      test('Then increment p1 forehand stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 1, 'into-the-net': 0, 'out': 0, 'winner': 1},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given p1 backhand into-the-net', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'BH',
          'depth': 'N',
          'winner': 'p2'
        }
      ];
      test('Then increment p1 backhand stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 1, 'into-the-net': 1, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
    group('Given p1 backhand out', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'BH',
          'depth': 'O',
          'winner': 'p2'
        }
      ];
      test('Then increment p1 backhand stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 1, 'into-the-net': 0, 'out': 1, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
    group('Given p1 backhand winner', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'BH',
          'depth': 'I',
          'winner': 'p1'
        }
      ];
      test('Then increment p1 backhand stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 1, 'into-the-net': 0, 'out': 0, 'winner': 1},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given p1 volley into-the-net', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'V',
          'depth': 'N',
          'winner': 'p2'
        }
      ];
      test('Then increment p1 volley stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 1, 'into-the-net': 1, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
    group('Given p1 volley out', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'V',
          'depth': 'O',
          'winner': 'p2'
        }
      ];
      test('Then increment p1 volley stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 1, 'into-the-net': 0, 'out': 1, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
    group('Given p1 volley winner', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'V',
          'depth': 'I',
          'winner': 'p1'
        }
      ];
      test('Then increment p1 volley stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 1, 'into-the-net': 0, 'out': 0, 'winner': 1},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given p1 smash into-the-net', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'SM',
          'depth': 'N',
          'winner': 'p2'
        }
      ];
      test('Then increment p1 smash stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 1, 'into-the-net': 1, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
    group('Given p1 smash out', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'SM',
          'depth': 'O',
          'winner': 'p2'
        }
      ];
      test('Then increment p1 smash stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 1, 'into-the-net': 0, 'out': 1, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
    group('Given p1 smash winner', () {
      final events = [
        {
          'event': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'SM',
          'depth': 'I',
          'winner': 'p1'
        }
      ];
      test('Then increment p1 smash stats', () {
        expect(decidingPoints(events: events), {
          'points': 1,
          'p1': {
            'points': 1,
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 1, 'into-the-net': 0, 'out': 0, 'winner': 1},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
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
            'forehand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'backhand': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });

    group('Given a 3 set sample data', () {
      final file =
          new File('test_resources/2021-09-24-andre-angelo-pirituba.json');
      test('Then generate the stats', () async {
        final MatchesStorage storage = MatchesStorage();
        final match = await storage.loadMatch(file);
        List<Map<String, dynamic>> events =
            new List<Map<String, dynamic>>.from(match['events']);
        expect(decidingPoints(events: events), {
          'points': 212,
          'p1': {
            'points': 115,
            'service': {
              'points': 20,
              'faults': 48,
              'double-fault': 19,
              'ace': 1,
              'shots': 68,
              'into-the-net': 22,
              'out': 45,
              'in': 1
            },
            'forehand': {
              'points': 53,
              'into-the-net': 16,
              'out': 29,
              'winner': 8
            },
            'backhand': {
              'points': 41,
              'into-the-net': 9,
              'out': 25,
              'winner': 7
            },
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 1, 'into-the-net': 0, 'out': 0, 'winner': 1}
          },
          'p2': {
            'points': 97,
            'service': {
              'points': 19,
              'faults': 52,
              'double-fault': 18,
              'ace': 1,
              'shots': 71,
              'into-the-net': 23,
              'out': 47,
              'in': 1
            },
            'forehand': {
              'points': 51,
              'into-the-net': 16,
              'out': 24,
              'winner': 11
            },
            'backhand': {
              'points': 23,
              'into-the-net': 11,
              'out': 10,
              'winner': 2
            },
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 4, 'into-the-net': 1, 'out': 1, 'winner': 2}
          }
        });
      });
    });

    group('Given a 5 sets sample data', () {
      final file =
          new File('test_resources/2021-09-26T09:46:41.089075.match.json');
      test('Then generate the stats', () async {
        final MatchesStorage storage = MatchesStorage();
        final match = await storage.loadMatch(file);
        List<Map<String, dynamic>> events =
            new List<Map<String, dynamic>>.from(match['events']);
        expect(decidingPoints(events: events), {
          'points': 238,
          'p1': {
            'points': 114,
            'service': {
              'points': 6,
              'faults': 38,
              'double-fault': 6,
              'ace': 0,
              'shots': 44,
              'into-the-net': 20,
              'out': 24,
              'in': 0
            },
            'forehand': {
              'points': 43,
              'into-the-net': 12,
              'out': 22,
              'winner': 9
            },
            'backhand': {
              'points': 62,
              'into-the-net': 14,
              'out': 43,
              'winner': 5
            },
            'smash': {'points': 1, 'into-the-net': 0, 'out': 1, 'winner': 0},
            'volley': {'points': 2, 'into-the-net': 0, 'out': 1, 'winner': 1}
          },
          'p2': {
            'points': 124,
            'service': {
              'points': 25,
              'faults': 63,
              'double-fault': 25,
              'ace': 0,
              'shots': 88,
              'into-the-net': 38,
              'out': 50,
              'in': 0
            },
            'forehand': {
              'points': 63,
              'into-the-net': 22,
              'out': 33,
              'winner': 8
            },
            'backhand': {
              'points': 36,
              'into-the-net': 13,
              'out': 18,
              'winner': 5
            },
            'smash': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0},
            'volley': {'points': 0, 'into-the-net': 0, 'out': 0, 'winner': 0}
          }
        });
      });
    });
  });
}
