import 'package:intl/intl.dart';

final date = DateFormat('dd/MM/yyyy - hh:mm');

dateToStr(DateTime dateUser) {
  return date.format(dateUser);
}
