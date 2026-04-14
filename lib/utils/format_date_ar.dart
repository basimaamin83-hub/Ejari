import 'package:intl/intl.dart' hide TextDirection;

String formatDateAr(DateTime d) {
  try {
    return DateFormat.yMMMMd('ar').format(d);
  } catch (_) {
    return '${d.day}/${d.month}/${d.year}';
  }
}
