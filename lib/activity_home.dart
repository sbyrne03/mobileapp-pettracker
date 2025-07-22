// Class to dispaly the way to log activities that the pet does including drinking water, eating, walking, etc. This is the second button on the navigation bar

import 'package:flutter/material.dart';
import "activity_class.dart"; // not using
import "pet_class.dart";
import "activities_list.dart";
import "util.dart";

// Testing Pets
var charlie = Pet('Charlie', 'Dog', 'Pit Bull', 60);
var daisy = Pet('Daisy', 'Cat', 'Shorthair', 8);

Activity a = Activity(
      activityName: 'Running',
      activityType: 'Exercise',
      activityDesc: 'This is a description',
      activityDate: '5/12');

class ActivitiesHome extends StatelessWidget {
  const ActivitiesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivitiesHomeInteractive(); // Return ActivitiesHomeInteractive directly
  }
}

class ActivitiesHomeInteractive extends StatefulWidget {
  const ActivitiesHomeInteractive({super.key});

  @override
  State<ActivitiesHomeInteractive> createState() =>
      _ActivitiesHomeInteractiveState();
}

class _ActivitiesHomeInteractiveState extends State<ActivitiesHomeInteractive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBarUni(),
        // Centered Column
        body: Center(
          // eventually may need to be made into a list that can be added to if we implement the ability
          // to add and delete animals
            child: Column(children: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width /
                      25, // Set width to screen width with relative padding
              height: MediaQuery.of(context).size.height /
                  2.55, // Set height to be proportionate to screen
              // ClipRRect class: https://api.flutter.dev/flutter/widgets/ClipRRect-class.html
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to ActivitiesList screen when the image is clicked
                      // this way there is a back button
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivitiesList(currentPet: daisy),
                        ),
                      );
                    },
                    // Stack containing cat picture and text, currently const, but will change once ability to
                    // create new pets is created
                    child: const Stack(fit: StackFit.expand, children: [
                      Image(
                        image: AssetImage('assets/Ada.jpg'),
                        fit: BoxFit
                            .cover, // Cover the entire square without stretching
                      ),
                      Center(
                        child: Text('Ada\'s Activity',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w800)))
                    ]),
                  ))),
          // Padding in between profiles
          Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 75)),
          // Start of new profile
          SizedBox(
            width: MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width /
                    25, // Set width to screen width with relative padding
            height: MediaQuery.of(context).size.height /
                2.55, // Set height to be proportionate to screen, will have to change once the ability to have more than two pets is made
            // ClipRRect sets the edges to be circular
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to ActivitiesList screen when the image is clicked
                    // this way there is a back button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivitiesList(currentPet: charlie),
                      ),
                    );
                  },
                  // Stack containing dog picture and text, currently const, but will change once ability to
                  // create new pets is created
                  child: const Stack(fit: StackFit.expand, children: [
                    Image(
                      image: AssetImage('assets/Nova.jpg'),
                      fit: BoxFit
                          .cover, // Cover the entire square without stretching
                    ),
                    Center(
                            child: Text('Nova\'s Activity',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800)))
                  ]),
                )),
          )
        ])));
  }
}
