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
