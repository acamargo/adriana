Map newRallyEvent({
  required DateTime createdAt,
  required Map match,
  required String player,
  required String shot,
  required String direction,
  required String depth,
  required String consistency,
}) {
  Map score = match['events'].last;
  String whoIsServing = score['server'];
  String whoIsReceiving = whoIsServing == "p1" ? "p2" : "p1";
  var winner;
  if (shot == "F") {
    winner = null;
  } else if (shot == "DF") {
    winner = whoIsReceiving;
  } else if (shot == "A") {
    winner = whoIsServing;
  } else if (['N', 'L', 'W'].contains(depth)) {
    winner = player == "p1" ? "p2" : "p1";
  } else if (['S', 'D'].contains(depth)) {
    winner = player;
  }

  return {
    'event': 'Rally',
    'createdAt': createdAt,
    'lastHitBy': player,
    'consistency': consistency,
    'shot': shot,
    'direction': direction,
    'depth': depth,
    'winner': winner,
  };
}
