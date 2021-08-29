import 'score.dart';

Map newMatch({
  required DateTime createdAt,
  required String p1,
  required String p2,
  required String surface,
  required String venue,
}) {
  return {
    'createdAt': createdAt,
    'p1': p1,
    'p2': p2,
    'surface': surface,
    'venue': venue,
    'events': [
      newFirstScore(createdAt),
    ],
  };
}
