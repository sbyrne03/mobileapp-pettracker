// Class to display the calendar tab that can be found on the navigation bar
// Source: https://pub.dev/packages/table_calendar
// Source: https://stackoverflow.com/questions/54480937/what-does-context-of-widget-buildbuildcontext-context-mean-in-flutter
// ignore_for_file: library_private_types_in_public_api

import 'util.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import "appointment_class.dart";

// builds calender widget
class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalendarScreen();
  }
}

// manages calender state
class CalendarScreen extends StatefulWidget {
  final Function(Map<DateTime, List<Appointment>>)? onAppointmentsUpdated;

  const CalendarScreen({super.key, this.onAppointmentsUpdated});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

// holds calender state and logic
class CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  Map<DateTime, List<Appointment>> appointments = {};

  // method to add appointments
  void addAppointment() async {
    // choose a date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(2010, 1, 1),
      lastDate: DateTime.utc(2030, 12, 31),
    );

    if (pickedDate != null) {
      // if a date is picked, now pick a time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // if a time is picked, creates date and time object 
        final DateTime appointmentDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // appointment description
        final String? description = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            String inputDescription = '';
            return AlertDialog(
              title: const Text('Description'),
              content: TextField(
                onChanged: (value) {
                  inputDescription = value;
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(inputDescription);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );

        if (description != null && description.isNotEmpty) {
          // if description is entered, create appointment object
          setState(() {
            final appointment = Appointment(
              date: appointmentDateTime,
              description: description,
            );

            // gets date from date time object
            final appointmentDate = DateTime(
              appointmentDateTime.year,
              appointmentDateTime.month,
              appointmentDateTime.day,
            );

            // add the appointment to the appointments map
            if (appointments.containsKey(appointmentDate)) {
              appointments[appointmentDate]!.add(appointment);
            } else {
              appointments[appointmentDate] = [appointment];
            }
          });
          
          if (widget.onAppointmentsUpdated != null) {
            widget.onAppointmentsUpdated!(appointments);
          }
        }
      }
    }
  }

  // method to show appointments for each day
  void showAppointments(BuildContext context) {
    final selectedAppointments = appointments[DateTime(
      // gets appointments for that day
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    )] ?? [];

    // show the appointments in the popup 
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: selectedAppointments.length,
          itemBuilder: (context, index) {
            final appointment = selectedAppointments[index];
            return ListTile(
              title: Text(appointment.getFormattedDateTime()),
              subtitle: Text('Description: ${appointment.description}'),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBarUni(),
      body: Column(
        children: [
          // widget displays calendar
          TableCalendar(
            focusedDay: focusedDate,
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(selectedDate, day),
            onDaySelected: (date, _) {
              // update selected day and shown appointments
              setState(() {
                selectedDate = date;
              });
              showAppointments(context);
            },
            onPageChanged: (date) {
              // update focused date when calendar page is changed
              setState(() {
                focusedDate = date;
              });
            },
            eventLoader: (day) => appointments[day] ?? [],
          ),
          const SizedBox(height: 20),
          // display selected date
          Text(
            'Selected Date: ${selectedDate.toString().split(' ')[0]}',
            style: const TextStyle(fontSize: 20),
          ),
          // button to add new appointment
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: FloatingActionButton(
              onPressed: addAppointment,
              backgroundColor: Color.fromARGB(255, 225, 175, 100),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}