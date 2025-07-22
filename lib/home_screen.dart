import 'package:flutter/material.dart';
import "pet_profile.dart";
import "appointment_class.dart";
import "util.dart";

// display appointments is a stateless widget that displays a list of appointments
class DisplayAppointments extends StatelessWidget {
  final Map<DateTime, List<Appointment>> appointments;

  // the appointments map is where the key is the data and time adn the value is a list of appointments
  const DisplayAppointments({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    // convert the appointments map to a list
    final appointmentsList = appointments.entries.expand((entry) {
      final appointmentsForDate = entry.value;
      return appointmentsForDate.map((appointment) {
        return ListTile(
          title: Text(appointment.getFormattedDateTime()),
          subtitle: Text('Description: ${appointment.description}'),
        );
      });
    }).toList();

    // returns list view with the list of all appointments
    return ListView(
      children: appointmentsList,
    );
  }
}

// Class for displaying the pictures of your pets
class PetPictures extends StatelessWidget {
  const PetPictures({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PetProfile(
                      name: 'Nova',
                      age: '4',
                      weight: '26 lbs',
                      breed: 'Border Collie',
                      color: 'White black and brown',
                      imageAsset: 'assets/Nova.jpg')),
            );
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.height * .22,
            child: Stack(//to place text elements on top of photo
              fit: StackFit.expand,
              children: [
                ClipRRect(//to round corners of photos for aesthetics
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage('assets/Nova.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  alignment: Alignment(0, -1),
                  child: Text('Nova',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(//more versatile than "onPressed()" with most other widgets
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PetProfile(
                      name: 'Ada',
                      age: '6',
                      weight: '27 lbs',
                      breed: 'Boder Collie',
                      color: 'Black brown and white',
                      imageAsset: 'assets/Ada.jpg')),
            );
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .4,//using percentage of the screen instead of const pixel sizes
            width: MediaQuery.of(context).size.height * .22,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage('assets/Ada.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  alignment: Alignment(0, -1), //so that we don't need a wrapping widget
                  child: Text('Ada',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Main class for the home page, calls all other classes to build the home page
class HomePage extends StatelessWidget {
  final Map<DateTime, List<Appointment>> appointments;

  const HomePage({Key? key, required this.appointments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBarUni(),
      body: Column(
          children: <Widget>[
            // padding between app bar and picture
            Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100)),
            //display pictures
            const Flexible(child: PetPictures()),
            // display the list of appointments using a list view builder
             Expanded(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final date = appointments.keys.elementAt(index);
                  final appointmentsForDate = appointments[date]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // displays the date
                      Text(
                        'Date: ${date.toString().split(' ')[0]}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      // displays the appointments for each date
                      // ... is a spread operator used with maps can
                      // make a list of data into a list of widgets
                      // includes them as childern of this widget
                      // dynamic intergration
                      ...appointmentsForDate.map((appointment) {
                      return Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                        child:
                        Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 223, 193, 149), // Light yellow color
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text(
                              appointment.getFormattedDateTime(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              'Description: ${appointment.description}',
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ));
                    }).toList(),
                    const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ), 
          ],
        ), 
      /* floatingActionButton: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const buttonColor,
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ), */
    );
  }
}

