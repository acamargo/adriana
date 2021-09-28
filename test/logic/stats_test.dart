import 'dart:io';
import 'package:test/test.dart';

import 'package:adriana/logic/stats.dart';
import 'package:adriana/matches_storage.dart';

void main() {
  group('matchStats()', () {
    group('Given a 5 sets sample data', () {
      final file =
          new File('test_resources/2021-09-26T09:46:41.089075.match.json');
      test('Then generate the stats', () async {
        final MatchesStorage storage = MatchesStorage();
        final match = await storage.loadMatch(file);
        expect(matchStats(match: match), {
          'score': 'André 0/0 6-2 6-2 2-6 3-6 3-1',
          'match-time': '1:23',
          'p1': {
            'name': 'André',
            'results': [
              {
                'points-played': 238,
                'points-win': 126,
                'points-win-%': 52.94117647058824,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 72,
                '1st-serve-win': 36,
                '1st-serve-win-%': 51.42857142857142
              },
              {
                'points-played': 50,
                'points-win': 30,
                'points-win-%': 60.0,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 11,
                '1st-serve-win': 7,
                '1st-serve-win-%': 63.63636363636363
              },
              {
                'points-played': 57,
                'points-win': 34,
                'points-win-%': 59.64912280701754,
                'aces': 0,
                'double-faults': 0,
                '1st-serve-played': 16,
                '1st-serve-win': 11,
                '1st-serve-win-%': 73.33333333333333
              },
              {
                'points-played': 48,
                'points-win': 22,
                'points-win-%': 48.888888888888886,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 21,
                '1st-serve-win': 9,
                '1st-serve-win-%': 47.368421052631575
              },
              {
                'points-played': 52,
                'points-win': 22,
                'points-win-%': 43.13725490196079,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 11,
                '1st-serve-win': 2,
                '1st-serve-win-%': 18.181818181818183
              },
              {
                'points-played': 31,
                'points-win': 18,
                'points-win-%': 58.06451612903226,
                'aces': 0,
                'double-faults': 0,
                '1st-serve-played': 13,
                '1st-serve-win': 7,
                '1st-serve-win-%': 63.63636363636363
              }
            ]
          },
          'p2': {
            'name': 'Ângelo',
            'results': [
              {
                'points-played': 238,
                'points-win': 112,
                'points-win-%': 47.863247863247864,
                'aces': 0,
                'double-faults': 25,
                '1st-serve-played': 65,
                '1st-serve-win': 37,
                '1st-serve-win-%': 59.67741935483871
              },
              {
                'points-played': 50,
                'points-win': 20,
                'points-win-%': 40.816326530612244,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 14,
                '1st-serve-win': 7,
                '1st-serve-win-%': 50.0
              },
              {
                'points-played': 57,
                'points-win': 23,
                'points-win-%': 41.81818181818181,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 20,
                '1st-serve-win': 11,
                '1st-serve-win-%': 55.00000000000001
              },
              {
                'points-played': 48,
                'points-win': 26,
                'points-win-%': 54.166666666666664,
                'aces': 0,
                'double-faults': 6,
                '1st-serve-played': 12,
                '1st-serve-win': 6,
                '1st-serve-win-%': 60.0
              },
              {
                'points-played': 52,
                'points-win': 30,
                'points-win-%': 57.692307692307686,
                'aces': 0,
                'double-faults': 9,
                '1st-serve-played': 11,
                '1st-serve-win': 10,
                '1st-serve-win-%': 90.9090909090909
              },
              {
                'points-played': 31,
                'points-win': 13,
                'points-win-%': 48.148148148148145,
                'aces': 0,
                'double-faults': 2,
                '1st-serve-played': 8,
                '1st-serve-win': 3,
                '1st-serve-win-%': 60.0
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
