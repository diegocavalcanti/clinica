import 'package:intl/intl.dart';

dateToFullText(data) {
  return DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR').format(data);
}

dateToDateStr(data) {
  return DateFormat('dd/MM/yyyy', 'pt_BR').format(data);
}

dateToDateTimeStr(data) {
  return DateFormat('dd/MM/yyyy - hh:mm', 'pt_BR').format(data);
}
