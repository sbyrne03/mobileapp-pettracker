import 'dart:io';



import 'package:app2/reminder_class.dart';
import 'package:flutter/material.dart';
import './util.dart';


import 'package:datepicker_dropdown/datepicker_dropdown.dart'; //date picker dropdown input field
import 'package:datepicker_dropdown/order_format.dart';  //to install run $ flutter pub add datepicker_dropdown

// This page is the reminder page
// User's should be able to add reminders and check off old reminders that they have completed.
// Reminders will show what the user needs to do, at what time/date.
// The organization of the page will mainly be in list form.
// What needs to be implemented: the add reminder button, functionality of translating a Reminder object
// onto the page

// ListCheckboxTile Widget Code Source: https://api.flutter.dev/flutter/material/CheckboxListTile-class.html
// Flutter code sample for [CheckboxListTile].

class ReminderList extends StatelessWidget {
  const ReminderList({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReminderListInteractive(); 
  }
}

class ReminderListInteractive extends StatefulWidget {
  const ReminderListInteractive({super.key});

  @override
  State<ReminderListInteractive> createState() =>
      _ReminderListInteractiveState();
}

class _ReminderListInteractiveState extends State<ReminderListInteractive> {
  List<Reminder> reminders = [
  ]; // List to store reminders

  
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBarUni(),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${reminders[index].name} ${reminders[index].month}/${reminders[index].day}/${reminders[index].year}"),
            subtitle: Text(reminders[index].desc),
            trailing: Checkbox(
              value: reminders[index].complete,
              onChanged: (value) {
                setState(() {
                  reminders[index].complete = value!;
                  reminders.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addReminder();
        },
        backgroundColor: buttonColor,
        child: Icon(Icons.add,),
      ),
    );
  }

  void _addReminder() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController nameController = TextEditingController();
      TextEditingController descController = TextEditingController();
      int _selectedDay = 1; // Initial selected day
      int _selectedMonth = 1; // Initial selected month
      int _selectedYear = 2024; // Initial selected year

      return AlertDialog(
        title: Text("Add New Reminder"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            
            DropdownDatePicker( //used https://pub.dev/packages/datepicker_dropdown/example 
              locale: "en",
              dateformatorder: OrderFormat.MDY,
              isDropdownHideUnderline: true,
              isFormValidator: true,
              startYear: 2024,
              endYear: 2030,
              width: 10,
              selectedDay: _selectedDay,
              selectedMonth: _selectedMonth,
              selectedYear: _selectedYear,
              onChangedDay: (value) {
                setState(() {
                  _selectedDay = int.parse(value!);
                });
              },
              onChangedMonth: (value) {
                setState(() {
                  _selectedMonth = int.parse(value!);
                });
              },
              onChangedYear: (value) {
                setState(() {
                  _selectedYear = int.parse(value!);
                });
              },
              boxDecoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              showDay: true,
              dayFlex: 2,
              hintDay: 'Day',
              hintMonth: 'Month',
              hintYear: 'Year',
              hintTextStyle: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  descController.text.isNotEmpty) {
                setState(() {
                  reminders.add(
                    Reminder(
                      nameController.text,
                      descController.text,
                      _selectedYear,
                      _selectedMonth,
                      _selectedDay,
                    ),
                  );
                });
                nameController.clear();
                descController.clear();
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
          ),
          TextButton(
            onPressed: () {
              nameController.clear();
              descController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
          ),
        ],
      );
    },
  );
}

}
// To add: + button on the bottom left
// Integrate reminder class
// somehow be able to add and delete checklist tiles
