import 'package:intl/intl.dart';

extension XDateTime on DateTime {
  String get dayMonthYear => DateFormat('dd/MM/yyyy').format(this);
}