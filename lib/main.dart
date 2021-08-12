import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:path_provider/path_provider.dart';

class MatchesStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/matches.json');
  }

  Future<List> load() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final result = json.decode(contents);
      return result
          .map((item) => {
                'time': DateTime.parse(item['time']),
                'p1': item['p1'],
                'p2': item['p2'],
                'surface': item['surface'],
                'venue': item['venue'],
                'state': item['state'],
              })
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<File> save(List data) async {
    final file = await _localFile;

    final contents = json.encode(data, toEncodable: myEncode);
    return file.writeAsString(contents);
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
}

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
  //     .then((_) {
  //   runApp(MyApp());
  // });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      home: MatchesScreen(),
      //home: MyHomePage(title: 'Tennis'),
    );
  }
}

class MyReturnObject {
  String p1, p2, surface, venue;

  MyReturnObject(this.p1, this.p2, this.surface, this.venue);
}

class SomeDialog extends StatefulWidget {
  @override
  _SomeDialog createState() => _SomeDialog();
}

class _SomeDialog extends State<SomeDialog> {
  final p1Controller = TextEditingController();
  final p2Controller = TextEditingController();
  final surfaceController = TextEditingController();
  final venueController = TextEditingController();

  @override
  void dispose() {
    p1Controller.dispose();
    p2Controller.dispose();
    surfaceController.dispose();
    venueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New Match'),
      ),
      body: Column(
        children: [
          ListTile(
            title: TextField(
              decoration: InputDecoration(labelText: "Player 1"),
              controller: p1Controller,
            ),
          ),
          ListTile(
            title: TextField(
              decoration: InputDecoration(labelText: "Player 2"),
              controller: p2Controller,
            ),
          ),
          ListTile(
            title: TextField(
              decoration: InputDecoration(labelText: "Court surface"),
              controller: surfaceController,
            ),
          ),
          ListTile(
            title: TextField(
              decoration: InputDecoration(labelText: "Venue"),
              controller: venueController,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(MyReturnObject(
                  p1Controller.text,
                  p2Controller.text,
                  surfaceController.text,
                  venueController.text));
            },
            child: Text('SAVE'),
          ),
        ],
      ),
    );
  }
}

class MatchesScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List _log = [];

  void _add() async {
    MyReturnObject results =
        await Navigator.of(context).push(MaterialPageRoute<MyReturnObject>(
            builder: (BuildContext context) {
              return SomeDialog();
            },
            fullscreenDialog: true));
    if (results != null) {
      setState(() {
        _log.insert(0, {
          'time': DateTime.now(),
          'p1': results.p1,
          'p2': results.p2,
          'surface': results.surface,
          'venue': results.venue,
          'state': 'in progress',
        });
        widget.storage.save(_log);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.storage.load().then((List log) {
      setState(() {
        _log = log;
      });
    });
  }

  String _formatDateTime(DateTime asOf) {
    final now = DateTime.now();
    final difference = DateTime(asOf.year, asOf.month, asOf.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (difference == 0) {
      return DateFormat("Hm").format(asOf);
    } else if (difference == -1) {
      return "Yesterday";
    }
    return DateFormat("yyyy-MM-dd").format(asOf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
      ),
      body: ListView.builder(
        itemCount: _log.length,
        itemBuilder: (context, index) {
          final element = _log[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PointPage(element)));
              },
              title: Text(
                  '${element['p1']} vs ${element['p2']} - ${_formatDateTime(element['time'])}'),
              subtitle: Text(
                  '${element['surface']} - ${element['venue']} - ${element['state']}'),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Add match',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PointPage extends StatefulWidget {
  final Map match;

  const PointPage(this.match);

  @override
  _PointPageState createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  String _player = "";
  String _consistency = "";
  String _stroke = "";
  String _direction = "";
  String _depth = "";

  @override
  Widget build(BuildContext context) {
    bool isServing = _player == "p1";
    bool isServiceStroke = ["A", "F", "DF"].contains(_stroke);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text("André 0/40 0-0"),
      ),
      body: ListView(
        children: [
          Wrap(
            spacing: 10,
            children: [
              ChoiceChip(
                  label: Text(widget.match['p1']),
                  selected: _player == "p1",
                  onSelected: (bool selected) {
                    setState(() {
                      _player = "p1";
                    });
                  }),
              ChoiceChip(
                  label: Text(widget.match['p2']),
                  selected: _player == "p2",
                  onSelected: (bool selected) {
                    setState(() {
                      _player = "p2";
                    });
                  }),
            ],
          ),
          Divider(),
          Wrap(
            spacing: 10,
            children: [
              ChoiceChip(
                label: Text("first ball touch"),
                selected: _consistency == "1",
                onSelected: (bool selected) {
                  setState(() {
                    _consistency = "1";
                  });
                },
              ),
              ChoiceChip(
                label: Text("second ball touch"),
                selected: _consistency == "2",
                onSelected: (bool selected) {
                  setState(() {
                    _consistency = "2";
                  });
                },
              ),
              ChoiceChip(
                label: Text("third ball touch or more"),
                selected: _consistency == "3+",
                onSelected: (bool selected) {
                  setState(() {
                    _consistency = "3+";
                  });
                },
              ),
            ],
          ),
          Divider(),
          Wrap(
            spacing: 10,
            children: [
              if (isServing)
                ChoiceChip(
                    label: Text("ace"),
                    selected: _stroke == "A",
                    onSelected: (bool selected) {
                      setState(() {
                        _stroke = "A";
                      });
                    }),
              if (isServing)
                ChoiceChip(
                    label: Text("fault"),
                    selected: _stroke == "F",
                    onSelected: (bool selected) {
                      setState(() {
                        _stroke = "F";
                      });
                    }),
              if (isServing)
                ChoiceChip(
                    label: Text("double fault"),
                    selected: _stroke == "DF",
                    onSelected: (bool selected) {
                      setState(() {
                        _stroke = "DF";
                      });
                    }),
              ChoiceChip(
                  label: Text("groundstroke forehand"),
                  selected: _stroke == "GFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "GFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("groundstroke backhand"),
                  selected: _stroke == "GBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "GBH";
                    });
                  }),
              ChoiceChip(
                  label: Text("volley backhand"),
                  selected: _stroke == "VFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "VFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("volley backhand"),
                  selected: _stroke == "VBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "VBH";
                    });
                  }),
              ChoiceChip(
                  label: Text("smash"),
                  selected: _stroke == "SH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "SH";
                    });
                  }),
              ChoiceChip(
                  label: Text("lob"),
                  selected: _stroke == "L",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "L";
                    });
                  }),
              ChoiceChip(
                  label: Text("passing shot forehand"),
                  selected: _stroke == "PSFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "PSFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("passing shot backhand"),
                  selected: _stroke == "PSBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "PSBH";
                    });
                  }),
              ChoiceChip(
                  label: Text("tweener"),
                  selected: _stroke == "TW",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "TW";
                    });
                  }),
              ChoiceChip(
                  label: Text("drop shot forehand"),
                  selected: _stroke == "DSFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "DSFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("drop shot backhand"),
                  selected: _stroke == "DSBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "DSBH";
                    });
                  }),
              ChoiceChip(
                  label: Text("half-volley forehand"),
                  selected: _stroke == "HVFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "HVFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("half-volley backhand"),
                  selected: _stroke == "HVBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _stroke = "HVBH";
                    });
                  }),
            ],
          ),
          Divider(),
          Wrap(
            spacing: 10,
            children: [
              ChoiceChip(
                label: Text(isServiceStroke ? "T" : "cross-court"),
                selected: _direction == "CC",
                onSelected: (bool selected) {
                  setState(() {
                    _direction = "CC";
                  });
                },
              ),
              ChoiceChip(
                label: Text(isServiceStroke ? "body" : "middle-court"),
                selected: _direction == "MD",
                onSelected: (bool selected) {
                  setState(() {
                    _direction = "MD";
                  });
                },
              ),
              ChoiceChip(
                label: Text(isServiceStroke ? "wide" : "down-the-line"),
                selected: _direction == "DL",
                onSelected: (bool selected) {
                  setState(() {
                    _direction = "DL";
                  });
                },
              ),
            ],
          ),
          Divider(),
          Wrap(
            spacing: 10,
            children: [
              if (_stroke != "A")
                ChoiceChip(
                  label: Text("into the net"),
                  selected: _depth == "N",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "N";
                    });
                  },
                ),
              if (_stroke != "F" && _stroke != "DF")
                ChoiceChip(
                  label: Text("short"),
                  selected: _depth == "S",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "S";
                    });
                  },
                ),
              if (_stroke != "F" && _stroke != "DF")
                ChoiceChip(
                  label: Text("deep"),
                  selected: _depth == "D",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "D";
                    });
                  },
                ),
              if (_stroke != "A")
                ChoiceChip(
                  label: Text("long"),
                  selected: _depth == "L",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "L";
                    });
                  },
                ),
              if (_stroke != "A")
                ChoiceChip(
                  label: Text("wide"),
                  selected: _depth == "W",
                  onSelected: (bool selected) {
                    setState(() {
                      _depth = "W";
                    });
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.match);

  final Map match;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _logIndex = 0;
  var _log = [
    {
      'time': DateTime.now(),
      'pointNumber': 1,
      'isServing': true,
      'isServiceFault': false,
      'isTieBreak': false,
      'courtSide': 'deuce',
      'scoreGame': '0',
      'scoreGameOpponent': '0',
      'currentSet': 1,
      'scoreMatch': [0],
      'scoreMatchOpponent': [0],
      'scoreTieBreak': [0],
      'scoreTieBreakOpponent': [0],
      'pointNumberTieBreakStarted': 0,
      'pointResult': 'in progress',
    }
  ];

  void _lostThePoint() {
    setState(() {
      _log[_logIndex]['pointResult'] = 'lost';
      _logPoint(false);
    });
  }

  _currentPoint() {
    return {..._log[_logIndex]};
  }

  String _formatScore() {
    var point = _currentPoint();
    var action = point['isServing'] ? 'serving' : 'receiving';
    var game = point['isServing']
        ? '${point['scoreGame']}/${point['scoreGameOpponent']}'
        : '${point['scoreGameOpponent']}/${point['scoreGame']}';
    var tieBreak = point['isServing']
        ? '${point['scoreTieBreak'][point['currentSet'] - 1]}/${point['scoreTieBreakOpponent'][point['currentSet'] - 1]}'
        : '${point['scoreTieBreakOpponent'][point['currentSet'] - 1]}/${point['scoreTieBreak'][point['currentSet'] - 1]}';
    Iterable<Iterable<dynamic>> matchOrder = point['isServing']
        ? [
            point['scoreMatch'],
            point['scoreMatchOpponent'],
            point['scoreTieBreak'],
            point['scoreTieBreakOpponent']
          ]
        : [
            point['scoreMatchOpponent'],
            point['scoreMatch'],
            point['scoreTieBreakOpponent'],
            point['scoreTieBreak']
          ];
    String match = IterableZip(matchOrder).map((values) {
      if (values[0] == 7)
        return '${values[0]}-${values[1]}(${values[3]})';
      else if (values[1] == 7)
        return '(${values[2]})${values[0]}-${values[1]}';
      else
        return '${values[0]}-${values[1]}';
    }).join(' ');
    var courtSide = '${point['courtSide']} court';
    var service = point['isServiceFault'] ? ', second service' : '';
    String score = point['isTieBreak']
        ? 'tie-break $action at $courtSide$service $tieBreak $match'
        : '$action at $courtSide$service $game $match';
    return '${score[0].toUpperCase()}${score.substring(1)}';
  }

  void _logPoint(bool wonThePoint) {
    var winner = wonThePoint ? '' : 'Opponent';
    var looser = wonThePoint ? 'Opponent' : '';
    var newPoint = _currentPoint();

    if (newPoint['isTieBreak']) {
      // tiebreak
      print(newPoint['scoreTieBreak' + winner]);
      print(newPoint['currentSet']);
      newPoint['scoreTieBreak' + winner][newPoint['currentSet'] - 1]++;

      print(newPoint['pointNumber']);
      print(newPoint['pointNumberTieBreakStarted']);
      var numberOfTieBreakPoints =
          newPoint['pointNumber'] - newPoint['pointNumberTieBreakStarted'];
      if (numberOfTieBreakPoints.isEven) {
        newPoint['isServing'] = !newPoint['isServing'];
      }

      if (newPoint['scoreTieBreak' + winner][newPoint['currentSet'] - 1] >= 7 &&
          newPoint['scoreTieBreak' + looser][newPoint['currentSet'] - 1] <=
              (newPoint['scoreTieBreak' + winner][newPoint['currentSet'] - 1] -
                  2)) {
        newPoint['scoreMatch' + winner][newPoint['currentSet'] - 1]++;
        newPoint['scoreMatch' + winner].add(0);
        newPoint['scoreMatch' + looser].add(0);
        newPoint['scoreTieBreak' + winner].add(0);
        newPoint['scoreTieBreak' + looser].add(0);
        newPoint['currentSet']++;
        newPoint['isTieBreak'] = false;
      }
      newPoint['courtSide'] = newPoint['courtSide'] == 'deuce' ? 'Ad' : 'deuce';
    } else {
      // game
      if (newPoint['scoreGame' + winner] == '0') {
        newPoint['scoreGame' + winner] = '15';
      } else if (newPoint['scoreGame' + winner] == '15') {
        newPoint['scoreGame' + winner] = '30';
      } else if (newPoint['scoreGame' + winner] == '30') {
        newPoint['scoreGame' + winner] = '40';
      } else if (newPoint['scoreGame' + winner] == '40' &&
          newPoint['scoreGame' + looser] == '40') {
        newPoint['scoreGame' + winner] = 'Ad';
      } else if (newPoint['scoreGame' + winner] == '40' &&
          newPoint['scoreGame' + looser] == 'Ad') {
        newPoint['scoreGame' + winner] = '40';
        newPoint['scoreGame' + looser] = '40';
      } else {
        newPoint['scoreMatch' + winner][newPoint['currentSet'] - 1]++;
        newPoint['scoreGame' + winner] = '0';
        newPoint['scoreGame' + looser] = '0';
        newPoint['isServing'] = !newPoint['isServing'];
      }

      if (newPoint['scoreMatch' + winner][newPoint['currentSet'] - 1] == 6 &&
          newPoint['scoreMatch' + looser][newPoint['currentSet'] - 1] <= 4) {
        newPoint['scoreMatch' + winner].add(0);
        newPoint['scoreMatch' + looser].add(0);
        newPoint['scoreTieBreak' + winner].add(0);
        newPoint['scoreTieBreak' + looser].add(0);
        newPoint['currentSet']++;
        newPoint['courtSide'] =
            newPoint['courtSide'] == 'deuce' ? 'Ad' : 'deuce';
      } else if (newPoint['scoreMatch' + winner][newPoint['currentSet'] - 1] ==
              7 &&
          newPoint['scoreMatch' + looser][newPoint['currentSet'] - 1] == 5) {
        newPoint['scoreMatch' + winner].add(0);
        newPoint['scoreMatch' + looser].add(0);
        newPoint['scoreTieBreak' + winner].add(0);
        newPoint['scoreTieBreak' + looser].add(0);
        newPoint['currentSet']++;
        newPoint['courtSide'] =
            newPoint['courtSide'] == 'deuce' ? 'Ad' : 'deuce';
      } else if (newPoint['scoreMatch' + winner][newPoint['currentSet'] - 1] ==
              6 &&
          newPoint['scoreMatch' + looser][newPoint['currentSet'] - 1] == 6) {
        newPoint['pointNumberTieBreakStarted'] = newPoint['pointNumber'] + 1;
        newPoint['isTieBreak'] = true;
        newPoint['courtSide'] = 'deuce';
      }
    }

    if (_logIndex == (_log.length - 1)) {
      // appending new event
      newPoint['time'] = DateTime.now();
      newPoint['pointNumber']++;
      newPoint['pointResult'] = 'in progress';
      _log.add(newPoint);
    } else
      // overwriting via undo/redo
      _log[_logIndex] = newPoint;
    _logIndex++;

    print(_log);
  }

  void _wonThePoint() {
    setState(() {
      _log[_logIndex]['pointResult'] = 'won';
      _logPoint(true);
    });
  }

  void _undo() {
    setState(() {
      _logIndex--;
    });
  }

  void _redo() {
    setState(() {
      _logIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_formatScore()),
      ),
      body: ListView(children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.thumb_up),
            title: Text('You won the point.'),
            onTap: _wonThePoint,
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.thumb_down),
            title: Text('You lost the point.'),
            onTap: _lostThePoint,
          ),
        ),
        // if (_logIndex > 0 && _log.length > 1)
        //   Card(
        //     child: ListTile(
        //       leading: Icon(Icons.undo),
        //       title: Text('Undo'),
        //       onTap: _undo,
        //     ),
        //   ),
        // if (_logIndex < (_log.length - 1) && _log.length > 1)
        //   Card(
        //     child: ListTile(
        //       leading: Icon(Icons.redo),
        //       title: Text('Redo'),
        //       onTap: _redo,
        //     ),
        //   ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
