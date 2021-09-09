import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import '../matches_storage.dart';
import 'stats_screen.dart';
import '../logic/score.dart';
import '../logic/rally.dart';

class PointScreen extends StatefulWidget {
  final MatchesStorage storage = MatchesStorage();
  final Map match;

  PointScreen(this.match);

  @override
  _PointScreenState createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  String _player = '';
  String _consistency = '';
  String _shot = '';
  String _direction = '';
  String _depth = '';

  _storeRallyEvent() {
    Map rallyEvent = newRallyEvent(
        createdAt: DateTime.now(),
        match: widget.match,
        player: _player,
        consistency: _consistency,
        shot: _shot,
        direction: _direction,
        depth: _depth);
    Map scoreEvent = newScoreFromRally(
        DateTime.now(), widget.match, widget.match['events'].last, rallyEvent);

    widget.match['events'].add(rallyEvent);
    widget.match['events'].add(scoreEvent);
    widget.storage.create(widget.match);
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Finish':
        bool result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${widget.match['p1']} vs ${widget.match['p2']}"),
              content: Text("Would you like to finish the match?"),
              actions: [
                TextButton(
                  child: Text("YES"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(true);
                  },
                ),
                TextButton(
                  child: Text("NO"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                ),
              ],
            );
          },
        );
        if (result) {
          Map lastScore = widget.match['events'].last;
          Map finalScoreEvent = {
            'event': 'FinalScore',
            'createdAt': DateTime.now(),
            'pointNumber': lastScore['pointNumber'],
            'p1': lastScore['p1'],
            'p2': lastScore['p2'],
            'state': 'Match finished'
          };
          widget.match['events'].add(finalScoreEvent);
          widget.storage.create(widget.match);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StatsScreen(widget.match),
            ),
          );
        }
        break;
    }
  }

  List<Widget> _whoTouchedTheBallLast() {
    return [
      if (_player == '') Text("Who touched the ball last?"),
      Wrap(
        spacing: 10,
        children: [
          ChoiceChip(
              label: Text(widget.match['p1']),
              selected: _player == 'p1',
              onSelected: (bool selected) {
                setState(() => _player = 'p1');
              }),
          ChoiceChip(
              label: Text(widget.match['p2']),
              selected: _player == 'p2',
              onSelected: (bool selected) {
                setState(() => _player = 'p2');
              }),
        ],
      ),
      Divider(),
    ];
  }

  List<Widget> _whatWasTheRallyLength() {
    if (_player == '')
      return [];
    else
      return [
        if (_consistency == '') Text('What was the rally length?'),
        Wrap(
          spacing: 10,
          children: [
            if (isServing()) ...[
              ChoiceChip(
                label: Text('one shot'),
                selected: _consistency == '1',
                onSelected: (bool selected) {
                  setState(() {
                    _consistency = '1';
                  });
                },
              ),
              ChoiceChip(
                label: Text('three shots or more'),
                selected: _consistency == '3',
                onSelected: (bool selected) {
                  setState(() {
                    _consistency = '3';
                  });
                },
              ),
            ] else ...[
              ChoiceChip(
                label: Text('two shots'),
                selected: _consistency == '2',
                onSelected: (bool selected) {
                  setState(() {
                    _consistency = '2';
                  });
                },
              ),
              ChoiceChip(
                label: Text('four shots or more'),
                selected: _consistency == '4',
                onSelected: (bool selected) {
                  setState(() {
                    _consistency = '4';
                  });
                },
              ),
            ],
          ],
        ),
        Divider(),
      ];
  }

  Map score() {
    return widget.match['events'].last;
  }

  String whoIsServing() {
    return score()['server'];
  }

  String whoIsReceiving() {
    return whoIsServing() == 'p1' ? 'p2' : 'p1';
  }

  bool isServing() {
    return _player == whoIsServing();
  }

  bool isServiceStroke() {
    return ['A', 'F', 'DF'].contains(_shot);
  }

  List<Widget> _whatWasTheShotHit() {
    if (_consistency == '')
      return [];
    else
      return [
        if (_shot == '') Text("What was the shot hit?"),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10,
            children: [
              if (isServing() && _consistency == '1')
                ChoiceChip(
                    label: Text("ace"),
                    selected: _shot == "A",
                    onSelected: (bool selected) {
                      setState(() {
                        _shot = "A";
                      });
                    }),
              if (isServing() && !score()['isServiceFault'])
                ChoiceChip(
                    label: Text("fault"),
                    selected: _shot == "F",
                    onSelected: (bool selected) {
                      setState(() {
                        _shot = "F";
                      });
                    }),
              if (isServing() &&
                  score()['isServiceFault'] &&
                  _consistency == '1')
                ChoiceChip(
                    label: Text("double fault"),
                    selected: _shot == "DF",
                    onSelected: (bool selected) {
                      setState(() {
                        _shot = "DF";
                      });
                    }),
              ChoiceChip(
                  label: Text("groundstroke forehand"),
                  selected: _shot == "GFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "GFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("groundstroke backhand"),
                  selected: _shot == "GBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "GBH";
                    });
                  }),
              ChoiceChip(
                  label: Text("volley forehand"),
                  selected: _shot == "VFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "VFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("volley backhand"),
                  selected: _shot == "VBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "VBH";
                    });
                  }),
              ChoiceChip(
                  label: Text("smash"),
                  selected: _shot == "SH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "SH";
                    });
                  }),
              ChoiceChip(
                  label: Text("lob"),
                  selected: _shot == "L",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "L";
                    });
                  }),
              ChoiceChip(
                  label: Text("passing shot forehand"),
                  selected: _shot == "PSFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "PSFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("passing shot backhand"),
                  selected: _shot == "PSBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "PSBH";
                    });
                  }),
              ChoiceChip(
                  label: Text("tweener"),
                  selected: _shot == "TW",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "TW";
                    });
                  }),
              ChoiceChip(
                  label: Text("drop shot forehand"),
                  selected: _shot == "DSFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "DSFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("drop shot backhand"),
                  selected: _shot == "DSBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "DSBH";
                    });
                  }),
              ChoiceChip(
                  label: Text("half-volley forehand"),
                  selected: _shot == "HVFH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "HVFH";
                    });
                  }),
              ChoiceChip(
                  label: Text("half-volley backhand"),
                  selected: _shot == "HVBH",
                  onSelected: (bool selected) {
                    setState(() {
                      _shot = "HVBH";
                    });
                  }),
            ],
          ),
        ),
        Divider(),
      ];
  }

  @override
  Widget build(BuildContext context) {
    Map score = widget.match['events'].last;
    String whoIsServing = score['server'];
    String whoIsReceiving = whoIsServing == "p1" ? "p2" : "p1";
    bool isServing = _player == whoIsServing;
    bool isServiceStroke = ["A", "F", "DF"].contains(_shot);

    // Wakelock.enable();

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(formatScore(widget.match, widget.match['events'].last)),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Finish'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: _whoTouchedTheBallLast() +
              _whatWasTheRallyLength() +
              _whatWasTheShotHit() +
              [
                Text("What was the ball direction?"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 10,
                    children: [
                      if (isServiceStroke) ...[
                        ChoiceChip(
                          label: Text(
                              "${widget.match[whoIsReceiving]}'s forehand"),
                          selected: _direction == "FH",
                          onSelected: (bool selected) {
                            setState(() {
                              _direction = "FH";
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text("${widget.match[whoIsReceiving]}'s body"),
                          selected: _direction == "B",
                          onSelected: (bool selected) {
                            setState(() {
                              _direction = "B";
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text(
                              "${widget.match[whoIsReceiving]}'s backhand"),
                          selected: _direction == "BH",
                          onSelected: (bool selected) {
                            setState(() {
                              _direction = "BH";
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text("wide"),
                          selected: _direction == "W",
                          onSelected: (bool selected) {
                            setState(() {
                              _direction = "W";
                            });
                          },
                        ),
                      ] else ...[
                        ChoiceChip(
                          label: Text("cross-court"),
                          selected: _direction == "CC",
                          onSelected: (bool selected) {
                            setState(() {
                              _direction = "CC";
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text("middle-court"),
                          selected: _direction == "MD",
                          onSelected: (bool selected) {
                            setState(() {
                              _direction = "MD";
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text("down-the-line"),
                          selected: _direction == "DL",
                          onSelected: (bool selected) {
                            setState(() {
                              _direction = "DL";
                            });
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                Divider(),
                Text("Where did the ball land?"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 10,
                    children: [
                      if (_shot != "A")
                        ChoiceChip(
                          label: Text("into the net"),
                          selected: _depth == "N",
                          onSelected: (bool selected) {
                            setState(() {
                              _depth = "N";
                            });
                          },
                        ),
                      if (_shot != "F" && _shot != "DF")
                        ChoiceChip(
                          label: Text("short"),
                          selected: _depth == "S",
                          onSelected: (bool selected) {
                            setState(() {
                              _depth = "S";
                            });
                          },
                        ),
                      if (_shot != "F" && _shot != "DF")
                        ChoiceChip(
                          label: Text("deep"),
                          selected: _depth == "D",
                          onSelected: (bool selected) {
                            setState(() {
                              _depth = "D";
                            });
                          },
                        ),
                      if (_shot != "A")
                        ChoiceChip(
                          label: Text("long"),
                          selected: _depth == "L",
                          onSelected: (bool selected) {
                            setState(() {
                              _depth = "L";
                            });
                          },
                        ),
                      if (_shot != "A")
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
                ),
                Divider(),
                ElevatedButton(
                  onPressed: (_player != "" &&
                          _consistency != "" &&
                          _shot != "" &&
                          _direction != "" &&
                          _depth != "")
                      ? () {
                          _storeRallyEvent();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PointScreen(widget.match)));
                        }
                      : null,
                  child: Text('Save'),
                ),
              ],
        ),
      ),
    );
  }
}
