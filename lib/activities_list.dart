// Class to display the way to log activities that the pet does including drinking water, eating, walking
// This is the second button on the navigation bar

import 'package:flutter/material.dart';
import "activity_class.dart";
import "pet_class.dart"; 
import "util.dart";

// for passing object through pages: https://stackoverflow.com/questions/49217287/flutter-pass-objects-from-one-page-to-other-page
class ActivitiesList extends StatelessWidget {
  final currentPet; // Assuming currentPet can be of any type
  ActivitiesList({Key? key, required this.currentPet}) : super(key: key); //

  @override
  Widget build(BuildContext context) {
    return ActivitiesListInteractive(currentPet: currentPet);
  }
}

class ActivitiesListInteractive extends StatefulWidget {
  final currentPet; // Assuming currentPet can be of any type
  const ActivitiesListInteractive({Key? key, required this.currentPet}) : super(key: key);

  @override
  State<ActivitiesListInteractive> createState() =>
      _ActivitiesListInteractiveState();
}

class _ActivitiesListInteractiveState extends State<ActivitiesListInteractive> {
  String _selectedActivity = 'Exercise'; //
  bool isTapped = false; //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Activities'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBox('Water'),
                _buildBox('Exercise'),
                _buildBox('Food'),
              ],
            ),
            // separation between the parts
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
            ),
            // Beginning of content below icons
            // (Wouldn't work with just stack, so I put Expanded)
            // Stack is so that all the content is on top of each other, but the one that is shown
            // depend on which icon is currently tapped, it compares the label with the current Activity
            // variable and sets the visibility of the Widget based on if it's the same or not
            Expanded(
                child: Stack(children: [
              _buildBoxBelow('Water', widget.currentPet),
              _buildBoxBelow('Food', widget.currentPet),
              _buildBoxBelow('Exercise', widget.currentPet),
            ]))
          ],
        ),
      ),
    );
  }
  // end of main widget building

  // Build icon that can be tapped and change the user's view
  Widget _buildBox(String label) {
    Image image1 = const Image(
        image: AssetImage('./assets/exercise.png')); //default logo
    isTapped =
        _selectedActivity == label; //variable to hold which image if selected

    // if it's building the water widget then it uses to water logo
    if (label == 'Water') {
      image1 = const Image(image: AssetImage('./assets/waterdrop.png'));
    }
    // if it's building the food widget then it uses to food logo
    if (label == 'Food') {
      image1 = const Image(image: AssetImage('./assets/dogfood.png'));
    }

    return GestureDetector(
      onTap: () {
        // If icon is tapped, it changes what activity it is focused on
        setState(() {
          _selectedActivity = label; // Select the new one
        });
      },
      // Got help from ChatGPT to figure out AnimatedContainer
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: isTapped
            // if isTapped is false, then it's smaller
            ? MediaQuery.of(context).size.width / 3.5
            : MediaQuery.of(context).size.width / 5.5,
        height: isTapped
            // if isTapped is false, then it's smaller
            ? MediaQuery.of(context).size.height / 4
            : MediaQuery.of(context).size.height / 6.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              isTapped ? 40 : 25), // changes borders to make it oval shaped
          color: Color.fromARGB(255, 225, 175, 100), // Change color as needed
        ),
        // inside the animated container
        child: Center(
          child: Column(children: [
            // image container that changes size based on size of parent container
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 40),
              child: image1,
            ),
            // text container that changes font size based on if icon is tapped
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: isTapped ? 20 : 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // Function to build the content below the icons
  Widget _buildBoxBelow(String label, var currentPet) {
    bool show = false; //default is that it isn't shown
    // if it's building the same content as what is selected
    if (label == _selectedActivity) {
      show = true; // it will be shown
    }
    // create a new list with just this types activities to show
    List<Activity> thisActivities = [];
    for (int i = 0; i < currentPet.activities.length; i++) {
      // if the activity type is the same as the current category, then add it to the list
      if (currentPet.activities[i].getActivityType() == label) {
        thisActivities.add(currentPet.activities[i]);
      }
    }

    // Visibility class example found: https://stackoverflow.com/questions/44489804/how-to-show-hide-widgets-programmatically-in-flutter
    // other source: https://api.flutter.dev/flutter/widgets/Visibility-class.html
    return Visibility(
        visible: show, //variable decides if it is constructed or not
        // content list, user can add to list and delete from list
        // future: connect list to the date and change it based on the date
        child: Column(children: [
          Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ])),
          const Divider(), // separate headers from content
          // SizedBox used to keep it from overrunning the button
          SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                  // Column used to hold the activities.map, not sure what other widgets work with .map
                  child: Column(
                children: thisActivities.map((activity) {
                  // change to Dismissable
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      // Dismissible class source: https://api.flutter.dev/flutter/widgets/Dismissible-class.html
                      child: Dismissible(
                        background: Container(
                          color: Colors.red,
                        // not sure if this icon looks good here...
                        //   child: const Align(
                        //     alignment: Alignment.centerRight,
                        //     child: Icon(Icons.cancel_presentation, color: Colors.white54, ),)
                        // 
                        ),
                        key: Key(activity
                            .activityName), // Provide a unique key for each item
                        onDismissed: (direction) {
                          // when the row is dismissed
                          setState(() {
                            // Remove the item from the data source
                            thisActivities.remove(activity);
                            currentPet.activities.remove(activity);
                          });
                        },
                        // Row holding the information for each activity
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // activity name
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.25,
                              child: Text(
                                activity.activityName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child:
                                  // activity description
                                  Text(
                                activity.activityDesc,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            // spacer
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 5.5),
                            Text(
                              // activity date
                              activity.activityDate,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ));
                }).toList(), // Add a spacer to push the FloatingActionButton to the bottom
              ))),
          // Button that adds a task
          FloatingActionButton(
            onPressed: () {
              // pop up that allows the user to input new information
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // in this function so the variables only exist when you want to add new activities
                  String _activityName =
                      'Empty'; // variable holds new activities names
                  String _activityType =
                      label; // variable holds new activities types
                  String _activityDesc =
                      'Empty'; // variable holds new activities descriptions
                  String _activityDate =
                      'Empty'; // variable holds new activities dates
                  // Simple Dialog source: https://api.flutter.dev/flutter/material/SimpleDialog-class.html
                  return SimpleDialog(
                    // Used code from my previous app3 task app to use text form field
                    title: Text('Add $label'),
                    backgroundColor: backgroundColor,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 15),
                          child: Column(children: [
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "Name:"),
                              onChanged: (String? inputTitle) {
                                setState(() {
                                  // need to have catch if user inputs null
                                  _activityName = inputTitle!;
                                });
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Description:"),
                              onChanged: (String? inputDesc) {
                                setState(() {
                                  // need to have catch if user inputs null
                                  _activityDesc = inputDesc!;
                                });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "Date:"),
                              onChanged: (String? inputDate) {
                                setState(() {
                                  // need to have catch if user inputs null
                                  _activityDate = inputDate!;
                                });
                              },
                            ),
                          ])),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // save the input
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    // adds new activity to the list
                                    currentPet.addActivity(Activity(
                                      activityName: _activityName,
                                      activityType: _activityType,
                                      activityDesc: _activityDesc,
                                      activityDate: _activityDate,
                                    ));
                                  });
                                },
                                child: const Text("Save",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            // or close the dialog
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold)),
                            )
                          ]),
                    ],
                  );
                },
              );
            },
            backgroundColor: buttonColor,
            child: const Icon(Icons.add),
            // Set background color to amber
          ),
        ]));
  }
}
