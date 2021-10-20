import 'dart:io';
import 'package:test/test.dart';

import 'package:adriana/logic/stats.dart';
import 'package:adriana/matches_storage.dart';
import 'package:adriana/logic/stringfy.dart';

void main() {
  group('matchStats()', () {
    group('Given a 5 sets sample with empty fifth set', () {
      final file =
          new File('test_resources/2021-10-07T07:27:00.467303.match.json');
      test('Then generate the stats', () async {
        final MatchesStorage storage = MatchesStorage();
        final match = await storage.loadMatch(file);
        expect(matchStats(match: match), {
          'match-duration': [
            Duration(microseconds: 5912154162),
            Duration(microseconds: 1164214000),
            Duration(microseconds: 1283724047),
            Duration(microseconds: 1094462279),
            Duration(microseconds: 2369753836),
          ],
          'match-time': [
            {
              'start': DateTime.parse('2021-10-07 07:27:00.467303'),
              'end': DateTime.parse('2021-10-07 07:27:00.467303'),
            },
            {
              'start': DateTime.parse('2021-10-07 07:59:27.178893'),
              'end': DateTime.parse('2021-10-07 08:18:51.392893'),
            },
            {
              'start': DateTime.parse('2021-10-07 08:19:16.925583'),
              'end': DateTime.parse('2021-10-07 08:40:40.649630'),
            },
            {
              'start': DateTime.parse('2021-10-07 08:42:04.194297'),
              'end': DateTime.parse('2021-10-07 09:00:18.656576'),
            },
            {
              'start': DateTime.parse('2021-10-07 09:01:15.994431'),
              'end': DateTime.parse('2021-10-07 09:40:45.748267'),
            },
          ],
          'scores': [
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 09:40:45.748328'),
              'pointNumber': 210,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 5,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 7,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, André',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 08:18:51.392950'),
              'pointNumber': 38,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, André',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 08:40:40.649679'),
              'pointNumber': 83,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, Ângelo',
              'server': 'p1',
              'isServiceFault': false,
              'courtSide': 'ad',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 09:00:18.656617'),
              'pointNumber': 121,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, André',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'ad',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-10-07 09:40:45.748328'),
              'pointNumber': 210,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 5,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 7,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, André',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce',
            },
          ],
          'p1': {
            'name': 'Ângelo',
            'results': [
              {
                'points-played': 210,
                'points-won': 127,
                'points-won-%': 60,
                'return-points-played': 107,
                'return-points-won': 63,
                'return-points-won-%': 59,
                'service-points-played': 103,
                'service-points-won': 64,
                'service-points-won-%': 62,
                'winners': 21,
                'net-points-played': 3,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 1,
                'double-faults': 9,
                '1st-serve-played': 65,
                '1st-serve-won': 40,
                '1st-serve-won-%': 62,
                '2nd-serve-played': 38,
                '2nd-serve-won': 24,
                '2nd-serve-won-%': 63,
                'break-points-played': 20,
                'break-points-won': 11,
                'break-points-won-%': 55,
                'game-points-played': 38,
                'game-points-won': 23,
                'game-points-won-%': 61,
                'forehand-played': 61,
                'forehand-won': 12,
                'forehand-won-%': 20,
                'forehand-out': 37,
                'forehand-out-%': 61,
                'forehand-net': 12,
                'forehand-net-%': 20,
                'backhand-played': 30,
                'backhand-won': 4,
                'backhand-won-%': 13,
                'backhand-out': 20,
                'backhand-out-%': 67,
                'backhand-net': 6,
                'backhand-net-%': 20,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 2,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 2,
                'volley-net-%': 100,
              },
              {
                'points-played': 38,
                'points-won': 26,
                'points-won-%': 68,
                'return-points-played': 18,
                'return-points-won': 13,
                'return-points-won-%': 72,
                'service-points-played': 20,
                'service-points-won': 13,
                'service-points-won-%': 65,
                'winners': 6,
                'net-points-played': 1,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 1,
                'double-faults': 0,
                '1st-serve-played': 14,
                '1st-serve-won': 9,
                '1st-serve-won-%': 64,
                '2nd-serve-played': 6,
                '2nd-serve-won': 4,
                '2nd-serve-won-%': 67,
                'break-points-played': 3,
                'break-points-won': 3,
                'break-points-won-%': 100,
                'game-points-played': 6,
                'game-points-won': 6,
                'game-points-won-%': 100,
                'forehand-played': 15,
                'forehand-won': 4,
                'forehand-won-%': 27,
                'forehand-out': 8,
                'forehand-out-%': 53,
                'forehand-net': 3,
                'forehand-net-%': 20,
                'backhand-played': 3,
                'backhand-won': 1,
                'backhand-won-%': 33,
                'backhand-out': 2,
                'backhand-out-%': 67,
                'backhand-net': 0,
                'backhand-net-%': 0,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 1,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 1,
                'volley-net-%': 100,
              },
              {
                'points-played': 45,
                'points-won': 30,
                'points-won-%': 67,
                'return-points-played': 29,
                'return-points-won': 18,
                'return-points-won-%': 62,
                'service-points-played': 16,
                'service-points-won': 12,
                'service-points-won-%': 75,
                'winners': 4,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 10,
                '1st-serve-won': 8,
                '1st-serve-won-%': 80,
                '2nd-serve-played': 6,
                '2nd-serve-won': 4,
                '2nd-serve-won-%': 67,
                'break-points-played': 5,
                'break-points-won': 3,
                'break-points-won-%': 60,
                'game-points-played': 11,
                'game-points-won': 6,
                'game-points-won-%': 55,
                'forehand-played': 10,
                'forehand-won': 2,
                'forehand-won-%': 20,
                'forehand-out': 6,
                'forehand-out-%': 60,
                'forehand-net': 2,
                'forehand-net-%': 20,
                'backhand-played': 4,
                'backhand-won': 0,
                'backhand-won-%': 0,
                'backhand-out': 3,
                'backhand-out-%': 75,
                'backhand-net': 1,
                'backhand-net-%': 25,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 38,
                'points-won': 27,
                'points-won-%': 71,
                'return-points-played': 19,
                'return-points-won': 11,
                'return-points-won-%': 58,
                'service-points-played': 19,
                'service-points-won': 16,
                'service-points-won-%': 84,
                'winners': 3,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 1,
                '1st-serve-played': 11,
                '1st-serve-won': 9,
                '1st-serve-won-%': 82,
                '2nd-serve-played': 8,
                '2nd-serve-won': 7,
                '2nd-serve-won-%': 88,
                'break-points-played': 3,
                'break-points-won': 2,
                'break-points-won-%': 67,
                'game-points-played': 9,
                'game-points-won': 6,
                'game-points-won-%': 67,
                'forehand-played': 11,
                'forehand-won': 1,
                'forehand-won-%': 9,
                'forehand-out': 8,
                'forehand-out-%': 73,
                'forehand-net': 2,
                'forehand-net-%': 18,
                'backhand-played': 7,
                'backhand-won': 2,
                'backhand-won-%': 29,
                'backhand-out': 3,
                'backhand-out-%': 43,
                'backhand-net': 2,
                'backhand-net-%': 29,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 89,
                'points-won': 44,
                'points-won-%': 49,
                'return-points-played': 41,
                'return-points-won': 21,
                'return-points-won-%': 51,
                'service-points-played': 48,
                'service-points-won': 23,
                'service-points-won-%': 48,
                'winners': 8,
                'net-points-played': 2,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 30,
                '1st-serve-won': 14,
                '1st-serve-won-%': 47,
                '2nd-serve-played': 18,
                '2nd-serve-won': 9,
                '2nd-serve-won-%': 50,
                'break-points-played': 9,
                'break-points-won': 3,
                'break-points-won-%': 33,
                'game-points-played': 12,
                'game-points-won': 5,
                'game-points-won-%': 42,
                'forehand-played': 25,
                'forehand-won': 5,
                'forehand-won-%': 20,
                'forehand-out': 15,
                'forehand-out-%': 60,
                'forehand-net': 5,
                'forehand-net-%': 20,
                'backhand-played': 16,
                'backhand-won': 1,
                'backhand-won-%': 6,
                'backhand-out': 12,
                'backhand-out-%': 75,
                'backhand-net': 3,
                'backhand-net-%': 19,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 1,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 1,
                'volley-net-%': 100,
              },
            ],
          },
          'p2': {
            'name': 'André',
            'results': [
              {
                'points-played': 210,
                'points-won': 83,
                'points-won-%': 40,
                'return-points-played': 103,
                'return-points-won': 39,
                'return-points-won-%': 38,
                'service-points-played': 107,
                'service-points-won': 44,
                'service-points-won-%': 41,
                'winners': 18,
                'net-points-played': 2,
                'net-points-won': 2,
                'net-points-won-%': 100,
                'aces': 0,
                'double-faults': 17,
                '1st-serve-played': 37,
                '1st-serve-won': 17,
                '1st-serve-won-%': 46,
                '2nd-serve-played': 70,
                '2nd-serve-won': 27,
                '2nd-serve-won-%': 39,
                'break-points-played': 14,
                'break-points-won': 4,
                'break-points-won-%': 29,
                'game-points-played': 26,
                'game-points-won': 9,
                'game-points-won-%': 35,
                'forehand-played': 43,
                'forehand-won': 16,
                'forehand-won-%': 37,
                'forehand-out': 19,
                'forehand-out-%': 44,
                'forehand-net': 8,
                'forehand-net-%': 19,
                'backhand-played': 44,
                'backhand-won': 4,
                'backhand-won-%': 9,
                'backhand-out': 26,
                'backhand-out-%': 59,
                'backhand-net': 14,
                'backhand-net-%': 32,
                'smash-played': 1,
                'smash-won': 1,
                'smash-won-%': 100,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 2,
                'volley-won': 1,
                'volley-won-%': 50,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 1,
                'volley-net-%': 50,
              },
              {
                'points-played': 38,
                'points-won': 12,
                'points-won-%': 32,
                'return-points-played': 20,
                'return-points-won': 7,
                'return-points-won-%': 35,
                'service-points-played': 18,
                'service-points-won': 5,
                'service-points-won-%': 28,
                'winners': 1,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 4,
                '1st-serve-played': 5,
                '1st-serve-won': 2,
                '1st-serve-won-%': 40,
                '2nd-serve-played': 13,
                '2nd-serve-won': 3,
                '2nd-serve-won-%': 23,
                'break-points-played': 2,
                'break-points-won': 0,
                'break-points-won-%': 0,
                'game-points-played': 5,
                'game-points-won': 0,
                'game-points-won-%': 0,
                'forehand-played': 6,
                'forehand-won': 0,
                'forehand-won-%': 0,
                'forehand-out': 5,
                'forehand-out-%': 83,
                'forehand-net': 1,
                'forehand-net-%': 17,
                'backhand-played': 8,
                'backhand-won': 1,
                'backhand-won-%': 13,
                'backhand-out': 4,
                'backhand-out-%': 50,
                'backhand-net': 3,
                'backhand-net-%': 38,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 45,
                'points-won': 15,
                'points-won-%': 33,
                'return-points-played': 16,
                'return-points-won': 4,
                'return-points-won-%': 25,
                'service-points-played': 29,
                'service-points-won': 11,
                'service-points-won-%': 38,
                'winners': 6,
                'net-points-played': 2,
                'net-points-won': 2,
                'net-points-won-%': 100,
                'aces': 0,
                'double-faults': 5,
                '1st-serve-played': 12,
                '1st-serve-won': 6,
                '1st-serve-won-%': 50,
                '2nd-serve-played': 17,
                '2nd-serve-won': 5,
                '2nd-serve-won-%': 29,
                'break-points-played': 0,
                'break-points-won': 0,
                'break-points-won-%': 0,
                'game-points-played': 3,
                'game-points-won': 1,
                'game-points-won-%': 33,
                'forehand-played': 10,
                'forehand-won': 3,
                'forehand-won-%': 30,
                'forehand-out': 5,
                'forehand-out-%': 50,
                'forehand-net': 2,
                'forehand-net-%': 20,
                'backhand-played': 12,
                'backhand-won': 3,
                'backhand-won-%': 25,
                'backhand-out': 6,
                'backhand-out-%': 50,
                'backhand-net': 3,
                'backhand-net-%': 25,
                'smash-played': 1,
                'smash-won': 1,
                'smash-won-%': 100,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 1,
                'volley-won': 1,
                'volley-won-%': 100,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 38,
                'points-won': 11,
                'points-won-%': 29,
                'return-points-played': 19,
                'return-points-won': 3,
                'return-points-won-%': 16,
                'service-points-played': 19,
                'service-points-won': 8,
                'service-points-won-%': 42,
                'winners': 4,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 1,
                '1st-serve-played': 7,
                '1st-serve-won': 2,
                '1st-serve-won-%': 29,
                '2nd-serve-played': 12,
                '2nd-serve-won': 6,
                '2nd-serve-won-%': 50,
                'break-points-played': 0,
                'break-points-won': 0,
                'break-points-won-%': 0,
                'game-points-played': 1,
                'game-points-won': 1,
                'game-points-won-%': 100,
                'forehand-played': 9,
                'forehand-won': 4,
                'forehand-won-%': 44,
                'forehand-out': 4,
                'forehand-out-%': 44,
                'forehand-net': 1,
                'forehand-net-%': 11,
                'backhand-played': 9,
                'backhand-won': 0,
                'backhand-won-%': 0,
                'backhand-out': 7,
                'backhand-out-%': 78,
                'backhand-net': 2,
                'backhand-net-%': 22,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 89,
                'points-won': 45,
                'points-won-%': 51,
                'return-points-played': 48,
                'return-points-won': 25,
                'return-points-won-%': 52,
                'service-points-played': 41,
                'service-points-won': 20,
                'service-points-won-%': 49,
                'winners': 7,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 7,
                '1st-serve-played': 13,
                '1st-serve-won': 7,
                '1st-serve-won-%': 54,
                '2nd-serve-played': 28,
                '2nd-serve-won': 13,
                '2nd-serve-won-%': 46,
                'break-points-played': 12,
                'break-points-won': 4,
                'break-points-won-%': 33,
                'game-points-played': 17,
                'game-points-won': 7,
                'game-points-won-%': 41,
                'forehand-played': 18,
                'forehand-won': 9,
                'forehand-won-%': 50,
                'forehand-out': 5,
                'forehand-out-%': 28,
                'forehand-net': 4,
                'forehand-net-%': 22,
                'backhand-played': 15,
                'backhand-won': 0,
                'backhand-won-%': 0,
                'backhand-out': 9,
                'backhand-out-%': 60,
                'backhand-net': 6,
                'backhand-net-%': 40,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 1,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 1,
                'volley-net-%': 100,
              },
            ],
          },
          'winner': 'p1',
          'looser': 'p2',
          'score': 'Ângelo 6-0 6-1 6-1 5-7',
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
          'match-duration': [
            Duration(microseconds: 7540449736),
            Duration(microseconds: 1614179033),
            Duration(microseconds: 1766746133),
            Duration(microseconds: 1596043366),
            Duration(microseconds: 1705083896),
            Duration(microseconds: 858397308),
          ],
          'match-time': [
            {
              'start': DateTime.parse('2021-09-26 09:46:41.089075'),
              'end': DateTime.parse('2021-09-26 09:46:41.089075'),
            },
            {
              'start': DateTime.parse('2021-09-26 10:12:34.902676'),
              'end': DateTime.parse('2021-09-26 10:39:29.081709'),
            },
            {
              'start': DateTime.parse('2021-09-26 10:39:49.111766'),
              'end': DateTime.parse('2021-09-26 11:09:15.857899'),
            },
            {
              'start': DateTime.parse('2021-09-26 11:09:57.748813'),
              'end': DateTime.parse('2021-09-26 11:36:33.792179'),
            },
            {
              'start': DateTime.parse('2021-09-26 13:13:57.077945'),
              'end': DateTime.parse('2021-09-26 13:42:22.161841'),
            },
            {
              'start': DateTime.parse('2021-09-26 13:43:24.171621'),
              'end': DateTime.parse('2021-09-26 13:57:42.568929'),
            },
          ],
          'scores': [
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 13:57:42.568975'),
              'pointNumber': 238,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 3,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 3,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
              ],
              'state': 'first service, André',
              'server': 'p1',
              'isServiceFault': false,
              'courtSide': 'deuce',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 10:39:29.081756'),
              'pointNumber': 51,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, Ângelo',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'ad',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 11:09:15.857956'),
              'pointNumber': 108,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, Ângelo',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 11:36:33.792222'),
              'pointNumber': 156,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, Ângelo',
              'server': 'p2',
              'isServiceFault': false,
              'courtSide': 'deuce',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 13:42:22.161896'),
              'pointNumber': 208,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 3,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 0,
                },
              ],
              'state': 'first service, André',
              'server': 'p1',
              'isServiceFault': false,
              'courtSide': 'deuce',
            },
            {
              'event': 'Score',
              'createdAt': DateTime.parse('2021-09-26 13:57:42.568975'),
              'pointNumber': 238,
              'p1': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 3,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 3,
                },
              ],
              'p2': [
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 2,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 6,
                },
                {
                  'game': '0',
                  'tiebreak': null,
                  'set': 1,
                },
              ],
              'state': 'first service, André',
              'server': 'p1',
              'isServiceFault': false,
              'courtSide': 'deuce',
            },
          ],
          'p1': {
            'name': 'André',
            'results': [
              {
                'points-played': 238,
                'points-won': 126,
                'points-won-%': 53,
                'return-points-played': 128,
                'return-points-won': 70,
                'return-points-won-%': 55,
                'service-points-played': 110,
                'service-points-won': 56,
                'service-points-won-%': 51,
                'winners': 15,
                'net-points-played': 3,
                'net-points-won': 1,
                'net-points-won-%': 33,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 72,
                '1st-serve-won': 36,
                '1st-serve-won-%': 50,
                '2nd-serve-played': 38,
                '2nd-serve-won': 20,
                '2nd-serve-won-%': 53,
                'break-points-played': 17,
                'break-points-won': 11,
                'break-points-won-%': 65,
                'game-points-played': 34,
                'game-points-won': 20,
                'game-points-won-%': 59,
                'forehand-played': 60,
                'forehand-won': 10,
                'forehand-won-%': 17,
                'forehand-out': 32,
                'forehand-out-%': 53,
                'forehand-net': 18,
                'forehand-net-%': 30,
                'backhand-played': 42,
                'backhand-won': 4,
                'backhand-won-%': 10,
                'backhand-out': 26,
                'backhand-out-%': 62,
                'backhand-net': 12,
                'backhand-net-%': 29,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 2,
                'volley-won': 1,
                'volley-won-%': 50,
                'volley-out': 1,
                'volley-out-%': 50,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 51,
                'points-won': 31,
                'points-won-%': 61,
                'return-points-played': 27,
                'return-points-won': 17,
                'return-points-won-%': 63,
                'service-points-played': 24,
                'service-points-won': 14,
                'service-points-won-%': 58,
                'winners': 5,
                'net-points-played': 2,
                'net-points-won': 1,
                'net-points-won-%': 50,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 12,
                '1st-serve-won': 8,
                '1st-serve-won-%': 67,
                '2nd-serve-played': 12,
                '2nd-serve-won': 6,
                '2nd-serve-won-%': 50,
                'break-points-played': 5,
                'break-points-won': 3,
                'break-points-won-%': 60,
                'game-points-played': 10,
                'game-points-won': 6,
                'game-points-won-%': 60,
                'forehand-played': 15,
                'forehand-won': 2,
                'forehand-won-%': 13,
                'forehand-out': 8,
                'forehand-out-%': 53,
                'forehand-net': 5,
                'forehand-net-%': 33,
                'backhand-played': 6,
                'backhand-won': 0,
                'backhand-won-%': 0,
                'backhand-out': 3,
                'backhand-out-%': 50,
                'backhand-net': 3,
                'backhand-net-%': 50,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 1,
                'volley-won': 1,
                'volley-won-%': 100,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 57,
                'points-won': 34,
                'points-won-%': 60,
                'return-points-played': 34,
                'return-points-won': 17,
                'return-points-won-%': 50,
                'service-points-played': 23,
                'service-points-won': 17,
                'service-points-won-%': 74,
                'winners': 6,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 0,
                '1st-serve-played': 16,
                '1st-serve-won': 11,
                '1st-serve-won-%': 69,
                '2nd-serve-played': 7,
                '2nd-serve-won': 6,
                '2nd-serve-won-%': 86,
                'break-points-played': 5,
                'break-points-won': 2,
                'break-points-won-%': 40,
                'game-points-played': 11,
                'game-points-won': 6,
                'game-points-won-%': 55,
                'forehand-played': 14,
                'forehand-won': 3,
                'forehand-won-%': 21,
                'forehand-out': 9,
                'forehand-out-%': 64,
                'forehand-net': 2,
                'forehand-net-%': 14,
                'backhand-played': 9,
                'backhand-won': 0,
                'backhand-won-%': 0,
                'backhand-out': 6,
                'backhand-out-%': 67,
                'backhand-net': 3,
                'backhand-net-%': 33,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 48,
                'points-won': 21,
                'points-won-%': 44,
                'return-points-played': 21,
                'return-points-won': 12,
                'return-points-won-%': 57,
                'service-points-played': 27,
                'service-points-won': 9,
                'service-points-won-%': 33,
                'winners': 2,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 21,
                '1st-serve-won': 8,
                '1st-serve-won-%': 38,
                '2nd-serve-played': 6,
                '2nd-serve-won': 1,
                '2nd-serve-won-%': 17,
                'break-points-played': 2,
                'break-points-won': 2,
                'break-points-won-%': 100,
                'game-points-played': 3,
                'game-points-won': 2,
                'game-points-won-%': 67,
                'forehand-played': 16,
                'forehand-won': 2,
                'forehand-won-%': 13,
                'forehand-out': 8,
                'forehand-out-%': 50,
                'forehand-net': 6,
                'forehand-net-%': 38,
                'backhand-played': 9,
                'backhand-won': 1,
                'backhand-won-%': 11,
                'backhand-out': 5,
                'backhand-out-%': 56,
                'backhand-net': 3,
                'backhand-net-%': 33,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 52,
                'points-won': 22,
                'points-won-%': 42,
                'return-points-played': 31,
                'return-points-won': 14,
                'return-points-won-%': 45,
                'service-points-played': 21,
                'service-points-won': 8,
                'service-points-won-%': 38,
                'winners': 0,
                'net-points-played': 1,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 10,
                '1st-serve-won': 2,
                '1st-serve-won-%': 20,
                '2nd-serve-played': 11,
                '2nd-serve-won': 6,
                '2nd-serve-won-%': 55,
                'break-points-played': 2,
                'break-points-won': 2,
                'break-points-won-%': 100,
                'game-points-played': 3,
                'game-points-won': 3,
                'game-points-won-%': 100,
                'forehand-played': 7,
                'forehand-won': 0,
                'forehand-won-%': 0,
                'forehand-out': 4,
                'forehand-out-%': 57,
                'forehand-net': 3,
                'forehand-net-%': 43,
                'backhand-played': 11,
                'backhand-won': 1,
                'backhand-won-%': 9,
                'backhand-out': 8,
                'backhand-out-%': 73,
                'backhand-net': 2,
                'backhand-net-%': 18,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 1,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 1,
                'volley-out-%': 100,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 30,
                'points-won': 18,
                'points-won-%': 60,
                'return-points-played': 15,
                'return-points-won': 10,
                'return-points-won-%': 67,
                'service-points-played': 15,
                'service-points-won': 8,
                'service-points-won-%': 53,
                'winners': 2,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 0,
                '1st-serve-played': 13,
                '1st-serve-won': 7,
                '1st-serve-won-%': 54,
                '2nd-serve-played': 2,
                '2nd-serve-won': 1,
                '2nd-serve-won-%': 50,
                'break-points-played': 3,
                'break-points-won': 2,
                'break-points-won-%': 67,
                'game-points-played': 7,
                'game-points-won': 3,
                'game-points-won-%': 43,
                'forehand-played': 8,
                'forehand-won': 3,
                'forehand-won-%': 38,
                'forehand-out': 3,
                'forehand-out-%': 38,
                'forehand-net': 2,
                'forehand-net-%': 25,
                'backhand-played': 7,
                'backhand-won': 2,
                'backhand-won-%': 29,
                'backhand-out': 4,
                'backhand-out-%': 57,
                'backhand-net': 1,
                'backhand-net-%': 14,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
            ],
          },
          'p2': {
            'name': 'Ângelo',
            'results': [
              {
                'points-played': 238,
                'points-won': 112,
                'points-won-%': 47,
                'return-points-played': 110,
                'return-points-won': 54,
                'return-points-won-%': 49,
                'service-points-played': 128,
                'service-points-won': 58,
                'service-points-won-%': 45,
                'winners': 13,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 25,
                '1st-serve-played': 65,
                '1st-serve-won': 37,
                '1st-serve-won-%': 57,
                '2nd-serve-played': 63,
                '2nd-serve-won': 21,
                '2nd-serve-won-%': 33,
                'break-points-played': 15,
                'break-points-won': 9,
                'break-points-won-%': 60,
                'game-points-played': 32,
                'game-points-won': 17,
                'game-points-won-%': 53,
                'forehand-played': 46,
                'forehand-won': 7,
                'forehand-won-%': 15,
                'forehand-out': 23,
                'forehand-out-%': 50,
                'forehand-net': 16,
                'forehand-net-%': 35,
                'backhand-played': 56,
                'backhand-won': 6,
                'backhand-won-%': 11,
                'backhand-out': 35,
                'backhand-out-%': 63,
                'backhand-net': 15,
                'backhand-net-%': 27,
                'smash-played': 1,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 1,
                'smash-out-%': 100,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 51,
                'points-won': 20,
                'points-won-%': 39,
                'return-points-played': 24,
                'return-points-won': 10,
                'return-points-won-%': 42,
                'service-points-played': 27,
                'service-points-won': 10,
                'service-points-won-%': 37,
                'winners': 2,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 14,
                '1st-serve-won': 7,
                '1st-serve-won-%': 50,
                '2nd-serve-played': 13,
                '2nd-serve-won': 3,
                '2nd-serve-won-%': 23,
                'break-points-played': 2,
                'break-points-won': 1,
                'break-points-won-%': 50,
                'game-points-played': 5,
                'game-points-won': 2,
                'game-points-won-%': 40,
                'forehand-played': 9,
                'forehand-won': 2,
                'forehand-won-%': 22,
                'forehand-out': 3,
                'forehand-out-%': 33,
                'forehand-net': 4,
                'forehand-net-%': 44,
                'backhand-played': 11,
                'backhand-won': 2,
                'backhand-won-%': 18,
                'backhand-out': 5,
                'backhand-out-%': 45,
                'backhand-net': 4,
                'backhand-net-%': 36,
                'smash-played': 1,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 1,
                'smash-out-%': 100,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 57,
                'points-won': 23,
                'points-won-%': 40,
                'return-points-played': 23,
                'return-points-won': 6,
                'return-points-won-%': 26,
                'service-points-played': 34,
                'service-points-won': 17,
                'service-points-won-%': 50,
                'winners': 2,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 20,
                '1st-serve-won': 11,
                '1st-serve-won-%': 55,
                '2nd-serve-played': 14,
                '2nd-serve-won': 6,
                '2nd-serve-won-%': 43,
                'break-points-played': 0,
                'break-points-won': 0,
                'break-points-won-%': 0,
                'game-points-played': 6,
                'game-points-won': 2,
                'game-points-won-%': 33,
                'forehand-played': 15,
                'forehand-won': 2,
                'forehand-won-%': 13,
                'forehand-out': 7,
                'forehand-out-%': 47,
                'forehand-net': 6,
                'forehand-net-%': 40,
                'backhand-played': 17,
                'backhand-won': 3,
                'backhand-won-%': 18,
                'backhand-out': 9,
                'backhand-out-%': 53,
                'backhand-net': 5,
                'backhand-net-%': 29,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 48,
                'points-won': 27,
                'points-won-%': 56,
                'return-points-played': 27,
                'return-points-won': 18,
                'return-points-won-%': 67,
                'service-points-played': 21,
                'service-points-won': 9,
                'service-points-won-%': 43,
                'winners': 2,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 12,
                '1st-serve-won': 6,
                '1st-serve-won-%': 50,
                '2nd-serve-played': 9,
                '2nd-serve-won': 3,
                '2nd-serve-won-%': 33,
                'break-points-played': 6,
                'break-points-won': 4,
                'break-points-won-%': 67,
                'game-points-played': 9,
                'game-points-won': 6,
                'game-points-won-%': 67,
                'forehand-played': 6,
                'forehand-won': 1,
                'forehand-won-%': 17,
                'forehand-out': 5,
                'forehand-out-%': 83,
                'forehand-net': 0,
                'forehand-net-%': 0,
                'backhand-played': 9,
                'backhand-won': 0,
                'backhand-won-%': 0,
                'backhand-out': 6,
                'backhand-out-%': 67,
                'backhand-net': 3,
                'backhand-net-%': 33,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 52,
                'points-won': 30,
                'points-won-%': 58,
                'return-points-played': 21,
                'return-points-won': 13,
                'return-points-won-%': 62,
                'service-points-played': 31,
                'service-points-won': 17,
                'service-points-won-%': 55,
                'winners': 2,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 9,
                '1st-serve-played': 11,
                '1st-serve-won': 10,
                '1st-serve-won-%': 91,
                '2nd-serve-played': 20,
                '2nd-serve-won': 7,
                '2nd-serve-won-%': 35,
                'break-points-played': 5,
                'break-points-won': 3,
                'break-points-won-%': 60,
                'game-points-played': 9,
                'game-points-won': 6,
                'game-points-won-%': 67,
                'forehand-played': 10,
                'forehand-won': 1,
                'forehand-won-%': 10,
                'forehand-out': 5,
                'forehand-out-%': 50,
                'forehand-net': 4,
                'forehand-net-%': 40,
                'backhand-played': 12,
                'backhand-won': 0,
                'backhand-won-%': 0,
                'backhand-out': 10,
                'backhand-out-%': 83,
                'backhand-net': 2,
                'backhand-net-%': 17,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
              {
                'points-played': 30,
                'points-won': 12,
                'points-won-%': 40,
                'return-points-played': 15,
                'return-points-won': 7,
                'return-points-won-%': 47,
                'service-points-played': 15,
                'service-points-won': 5,
                'service-points-won-%': 33,
                'winners': 5,
                'net-points-played': 0,
                'net-points-won': 0,
                'net-points-won-%': 0,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 8,
                '1st-serve-won': 3,
                '1st-serve-won-%': 38,
                '2nd-serve-played': 7,
                '2nd-serve-won': 2,
                '2nd-serve-won-%': 29,
                'break-points-played': 2,
                'break-points-won': 1,
                'break-points-won-%': 50,
                'game-points-played': 3,
                'game-points-won': 1,
                'game-points-won-%': 33,
                'forehand-played': 6,
                'forehand-won': 1,
                'forehand-won-%': 17,
                'forehand-out': 3,
                'forehand-out-%': 50,
                'forehand-net': 2,
                'forehand-net-%': 33,
                'backhand-played': 7,
                'backhand-won': 1,
                'backhand-won-%': 14,
                'backhand-out': 5,
                'backhand-out-%': 71,
                'backhand-net': 1,
                'backhand-net-%': 14,
                'smash-played': 0,
                'smash-won': 0,
                'smash-won-%': 0,
                'smash-out': 0,
                'smash-out-%': 0,
                'smash-net': 0,
                'smash-net-%': 0,
                'volley-played': 0,
                'volley-won': 0,
                'volley-won-%': 0,
                'volley-out': 0,
                'volley-out-%': 0,
                'volley-net': 0,
                'volley-net-%': 0,
              },
            ],
          },
          'winner': 'p1',
          'looser': 'p2',
          'score': 'André 6-2 6-2 2-6 3-6 3-1',
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
