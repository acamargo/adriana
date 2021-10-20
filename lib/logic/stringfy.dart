import 'dart:io';

Future<void> saveStringfiedVarToFile(String filename, dynamic input) {
  return File(filename).writeAsString(stringfyVar(input), flush: true);
}

String stringfyVar(dynamic input) {
  return 'var v = ${stringfyObject(input)};';
}

String stringfyObject(dynamic input) {
  String output = '';
  if (input is List)
    output += stringfyList(input);
  else if (input is Map)
    output += stringfyMap(input);
  else if (input is String)
    output += "'$input'";
  else if (input is DateTime)
    output += "DateTime.parse('$input')";
  else if (input is num)
    output += input.toString();
  else if (input is Duration)
    output += 'Duration(microseconds: ${input.inMicroseconds})';
  else if (input == null)
    output += 'null';
  else if (input is bool)
    output += input.toString();
  else
    output += "'!ERROR!'";
  return output;
}

String stringfyList(List<dynamic> input) {
  String output = '[';
  for (var i = 0; i < input.length; i++) {
    final item = input[i];
    output += stringfyObject(item) + ',';
  }
  return output + ']';
}

String stringfyMap(Map input) {
  String output = '{';
  input.forEach((k, v) => output += "'$k': ${stringfyObject(v)},");
  return output + '}';
}
