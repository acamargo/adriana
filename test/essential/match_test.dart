import 'package:test/test.dart';

import 'package:adriana/essential/match.dart';
import 'package:adriana/essential/score.dart';

void main() {
  group('Given a createdAt, p1, p2, venue and surface', () {
    final createdAt = DateTime.now();
    final p1 = 'Opelka';
    final p2 = 'Isner';
    final surface = 'Hard';
    final venue = 'Wiston-Salem';
    group('When create a Match', () {
      final match = newMatch(
          createdAt: createdAt, p1: p1, p2: p2, surface: surface, venue: venue);
      test('Then we have the right data structure', () {
        final firstScore = newFirstScore(createdAt);
        expect(
            match,
            allOf([
              containsPair('createdAt', createdAt),
              containsPair('p1', p1),
              containsPair('p2', p2),
              containsPair('surface', surface),
              containsPair('venue', venue),
              containsPair('events', [firstScore]),
            ]));
      });
    });
  });
}
