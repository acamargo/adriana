import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'matches_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.disable();
    return MaterialApp(
      title: 'Tennis Performance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: MatchesScreen(),
    );
  }
}
