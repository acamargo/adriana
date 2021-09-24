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
          'type': 'Rally',
          'server': 'p1',
          'lastHitBy': 'p1',
          'shot': 'SV',
          'depth': 'N',
          'winner': null
        },
        {
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
          'type': 'Rally',
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
  });
}
