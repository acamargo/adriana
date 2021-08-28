import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class MatchesStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<List<FileSystemEntity>> list() async {
    final directory = await getApplicationDocumentsDirectory();
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = directory.list(recursive: false);
    lister.listen((file) {
      if (file is File && file.path.endsWith('match.json')) files.add(file);
    },
        // should also register onError
        onDone: () => completer.complete(files));
    return completer.future;
  }

  Future<Map> _loadMatch(file) async {
    final contents = await file.readAsString();
    final result = json.decode(contents, reviver: (key, value) {
      if (key == "createdAt") return DateTime.parse(value as String);
      return value;
    });
    return result;
  }

  Future<List<Map>> loadAll() async {
    final directory = await getApplicationDocumentsDirectory();
    var files = directory
        .listSync(recursive: false)
        .where((file) => file is File && file.path.endsWith('match.json'))
        .toList()
          ..sort((fileA, fileB) => fileB.path.compareTo(fileA.path));
    return Future.wait(files.map((file) => _loadMatch(file)).toList());
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

  Future<File> create(Map data) async {
    final path = await _localPath;
    final fileName = data['createdAt'].toIso8601String();
    final file = File('$path/$fileName.match.json');
    print(file);
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
