import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class PreferencesStorage {
  Map _cache = {};

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // files are saved in /data/user/0/com.example.adriana/app_flutter/

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/preferences.json');
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  Future<File> save(Map data) async {
    final file = await _localFile;

    final contents = json.encode(data, toEncodable: myEncode);
    return file.writeAsString(contents);
  }

  Future<Map> load() async {
    if (_cache.isEmpty)
      try {
        final file = await _localFile;
        final contents = await file.readAsString();
        _cache = json.decode(contents);
      } catch (e) {
        _cache = {
          'screenOrientation': 'landscape',
          'vibrate': true,
          'sound': true
        };
      }
    return _cache;
  }

  Future<bool> isLandscape() async {
    await load();
    return _cache['screenOrientation'] == 'landscape';
  }

  Future<void> setLandscape(bool isLandscape) async {
    await load();
    _cache['screenOrientation'] = isLandscape ? 'landscape' : 'portrait';
    await save(_cache);
  }

  Future<bool> isVibrate() async {
    await load();
    return _cache['vibrate'];
  }

  Future<void> setVibrate(bool isVibrate) async {
    await load();
    _cache['vibrate'] = isVibrate;
    await save(_cache);
  }

  Future<bool> isSound() async {
    await load();
    return _cache['sound'];
  }

  Future<void> setSound(bool isSound) async {
    await load();
    _cache['sound'] = isSound;
    await save(_cache);
  }
}
