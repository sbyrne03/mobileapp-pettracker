// This class is where the data for the appointments the pet has are stored
import 'package:intl/intl.dart';

class Appointment {
  final DateTime date;
  final String description;

  Appointment({required this.date, required this.description});

  String getFormattedDate() {
    final dateFormat = DateFormat('EEEE, MMMM d, y');
    return dateFormat.format(date);
  }

  String getFormattedTime() {
    final timeFormat = DateFormat('h:mm a');
    return timeFormat.format(date);
  }

  String getFormattedDateTime() {
    return '${getFormattedDate()} - ${getFormattedTime()}';
  }
}