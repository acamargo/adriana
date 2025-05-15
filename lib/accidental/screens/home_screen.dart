import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'matches_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WakelockPlus.disable();
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
