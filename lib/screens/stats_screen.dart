import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  final match;

  StatsScreen(this.match);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Stats'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('${widget.match['p1']} vs ${widget.match['p2']}'),
          ],
        ),
      ),
    );
  }
}

// time played
// time point average

// |  24 points played in the match                                                                                                        |
// | 10 decided by p1 (1 hits/9 misses)                                                                                 | 14 decided by p2 |
// | 2 serve      | 6 forehand               | 2 backhand               | 0 volley              | 0 smash               |
// | 0 ace | 2 DF | 1 winner | 3 net | 2 out | 0 winner | 2 net | 0 out | 0 win | 0 net | 0 out | 0 win | 0 net | 0 out |

// points | total  | 1st set | 2nd set | 3rd set
// -------+--------+---------+---------+--------
// match  | 143    | 64      | 55      | 24
// p1     | 30/113 | 10/54
// p2     | 113/30 | 54/10
// * points
//    * number of points played/won/lost
//    * points won/lost by stroke
// * games
//   * number of games played/won/lost
//   * number of games played serving/won/lost
//   * number of games played receiving/won/lost
// * forehand
//   * overall number of hit/winner/into the net/out
// * backhand
//   * overall number of hit/winner/into the net/out
// * smash
//   * overall number of hit/winner/into the net/out
// * volley
//   * overall number of hit/winner/into the net/out
// * service
//   * overall number of services hit/ace/into the net/out
//   * 1st service 
//     * consistency (how many times the ball was in / the ball was into the net or out)
//     * points won (number of points won when the first serve was in / number of times the first serve was in)
//     * unreturned serves (number of times the opponent returned into the net or out / number of time the first serve was in)
//   * 2st service 
//     * consistency (how many times the ball was in / the ball was into the net or out)
//     * points won (number of points won when the first serve was in / number of times the first serve was in)
//     * unreturned serves (number of times the opponent returned into the net or out / number of time the first serve was in)
// 