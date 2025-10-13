import 'package:intl/intl.dart';

class GetAvailableTime {
  GetAvailableTime._();

  static String getTime(String utcString) {
    DateTime utcTime = DateTime.parse(utcString);
    DateTime aztTime = utcTime.add(const Duration(hours: 4));

    String availableTime = DateFormat('HH:mm').format(aztTime);

    return availableTime;
  }
}
