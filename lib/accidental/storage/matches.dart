import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class MatchesStorage {
  Future<String> get _localPath async {
    final directory = await getExternalSdCardPath();
    return directory.path;
  }

  Future<Map> loadMatch(file) async {
    final contents = await file.readAsString();
    final result = json.decode(contents, reviver: (key, value) {
      if (key == "createdAt") return DateTime.parse(value as String);
      return value;
    });
    return result;
  }

  Future<List<FileSystemEntity>> loadListMatches() async {
    final directory = await getExternalSdCardPath();
    var files = directory
        .listSync(recursive: false)
        .where((file) => file is File && file.path.endsWith('match.json'))
        .toList()
      ..sort((fileA, fileB) => fileB.path.compareTo(fileA.path));
    return files;
  }

  Future<Directory> getExternalSdCardPath() async {
    var directory = await getExternalStorageDirectory();

    String newPath = "";
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath = newPath + "/AdrianaTennisApp";

    final newDirectory = Directory(newPath);
    if (!await newDirectory.exists()) {
      await newDirectory.create(recursive: true);
    }

    return newDirectory;
  }

  Future copyFilesToSdCard() async {
    final directory = await getApplicationDocumentsDirectory();

    var files = directory
        .listSync(recursive: false)
        .where((file) =>
            file is File &&
            (file.path.endsWith('match.json') ||
                file.path.endsWith('match.xlsx')))
        .toList();

    final destination = await getExternalSdCardPath();
    if (!await destination.exists()) {
      await destination.create(recursive: true);
    }
    files.forEach((element) async {
      String basename = element.path.split('/').last;
      String finalDestination =
          destination.path + "/" + basename.replaceAll(':', '-');
      print('Copying $element.path to $finalDestination');
      await (element as File).copy(finalDestination);
    });
  }

  Future<File> create(Map data) async {
    final path = await _localPath;
    final fileName = data['createdAt'].toIso8601String().replaceAll(':', '-');
    final file = File('$path/$fileName.match.json');
    final contents = json.encode(data, toEncodable: myEncode);
    return file.writeAsString(contents);
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  bool exist(File path) {
    return path.existsSync();
  }

  Future<void> delete(Map data) async {
    final path = await _localPath;
    final fileName = data['createdAt'].toIso8601String().replaceAll(':', '-');
    try {
      final file = File('$path/$fileName.match.json');
      await file.delete();
    } catch (e) {}
    try {
      final file = File('$path/$fileName.match.xlsx');
      await file.delete();
    } catch (e) {}
  }
}
