import 'package:intl/intl.dart';

extension StringExtension on String {
  // DateFormat get monthFormatter => DateFormat.MMMd();
  bool get isNullOrEmpty => this == null || isEmpty;
  static DateFormat formatter = DateFormat.yMMMd();

  static String? asDate(String? input) => input == null ? null : DateFormat.yMMMd().format(DateTime.parse(input));
}

extension StringExtension2 on String? {
  // DateFormat get monthFormatter => DateFormat.MMMd();
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  static DateFormat formatter = DateFormat.yMMMd();

  static String? asDate(String? input) => input == null ? null : DateFormat.yMMMd().format(DateTime.parse(input));
}
