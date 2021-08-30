import 'package:intl/intl.dart';

String formatDateTime(DateTime asOf, DateTime now) {
  final difference = DateTime(asOf.year, asOf.month, asOf.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
  if (difference == 0) {
    return DateFormat("Hm").format(asOf);
  } else if (difference == -1) {
    return "Yesterday";
  }
  return DateFormat("yyyy-MM-dd").format(asOf);
}