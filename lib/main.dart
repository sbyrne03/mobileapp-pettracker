// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'appointment_class.dart';
import './calendar_screen.dart';
import 'util.dart';
import './reminder_screen.dart';
import './home_screen.dart';
import './activity_home.dart';

//this will be used to class MainPage extends StatefulWidget
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  // ordered list of the different pages that are used in the navbar 
  List<Widget> pages = [];
  int currIndex = 0; //current page index 0 = HomePage, 1 = ActivitiesList, etc.
  Map<DateTime, List<Appointment>> appointments = {};

  @override
  void initState() {
    super.initState();
    // initilize the pages list each of the widgets
    pages = [
      HomePage(appointments: appointments),
      ActivitiesHome(),
      CalendarScreen(onAppointmentsUpdated: _updateAppointments),
      const ReminderList(),
    ];
  }

  // callback function to update the appointments when they are modified in the calendar screen
  void _updateAppointments(Map<DateTime, List<Appointment>> updatedAppointments) {
    setState(() {
      // update the appointments map with the new appointments
      appointments = updatedAppointments;
      // update the homepage widget with the new appointments
      pages[0] = HomePage(appointments: appointments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this will initially load all pages and store them in an indexable stack
      //by doing this you are able to jump between pages with the navbar while maintaining page state
      body: IndexedStack(
        index: currIndex,
        //setting the page index
        children: pages,
        //referencing the above list
      ),
      // wed source for saving page state when using a navbar
      // https://www.nstack.in/blog/flutter-save-page-state-when-using-bottom-nav/
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          //button order should align with the above pages list order
          BottomNavigationBarItem(
            // HomePage tab
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            //Activities page tab
            icon: Icon(Icons.water_drop_outlined),
            label: 'activities',
          ),
          BottomNavigationBarItem(
            //Calendar tab
            icon: Icon(Icons.calendar_month),
            label: 'calendar',
          ),
          BottomNavigationBarItem(
            // reminders tab
            icon: Icon(Icons.alarm),
            label: 'reminders',
          ),
        ],
        currentIndex: currIndex,
        //reassigning the navbar index
        selectedItemColor: buttonColor,
        //making the selected button amber
        unselectedItemColor: Colors.grey,
        //making unselected buttons grey
        onTap: (index) {
          //setting the new page index for the navbar on every click
          setState(() {
            currIndex = index;
          });
        },
      ),
    );
  }
}

//initializing the app itself
class PetApp extends StatelessWidget {
  const PetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
      //displaying the main page that connects all other pages through the nav bar
    );
  }
}

void main() => runApp(const PetApp()); //main function call