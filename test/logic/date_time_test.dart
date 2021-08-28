import 'package:test/test.dart';

import 'package:adriana/logic/date_time.dart';

void main() {
  group('Given an asOf', () {
    group('When asOf is the same day as now', () {
      test('Then returns only the time', () {
        var asOf = DateTime.parse('2021-08-28T10:11:12');
        var now = DateTime.parse('2021-08-28T20:21:22');
        expect(formatDateTime(asOf, now), equals('10:11'));
      });
    });
    group('When asOf is the day after now', () {
      test('Then returns "yesterday"', () {
        var asOf = DateTime.parse('2021-08-28T20:21:21');
        var now = DateTime.parse('2021-08-29T01:02:03');
        expect(formatDateTime(asOf, now), equals('Yesterday'));
      });
    });
    group('When asOf is older than yesterdays', () {
      test('Then returns the day formatted as YYYY-mm-dd', () {
        var asOf = DateTime.parse('2021-08-27T20:21:21');
        var now = DateTime.parse('2021-08-29T01:02:03');
        expect(formatDateTime(asOf, now), equals('2021-08-27'));
      });
    });
  });
}
