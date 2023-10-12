import 'package:intl/intl.dart';

class DateFormatter{
  static String dateFormatter(DateTime now) {
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(now);
    return outputDate;
  }
}