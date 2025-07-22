// This pet class is meant to represent the pets of the users. It will hold all the valuable information
// on each pet. Information will be updated frequently and there will be classes used within this class, 
// such as the vaccination class to be made in the future. 

// Attributes: name will hold the pet's name, age will hold the pet's age, type will hold either cat
// or dog, breed will hold the breed of the animal, weight will hold the pet's weight. 
// Other Attributes to be added once other classes are made: Vaccinations, Health Records, Activity records,
// Nutritional guidance, Appointments, and Insurance. -> I'm thinking accessing some of these could be a
// date->info map.

// Methods: Setters for all attributes. 
// Other methods associated with the other classes. 
import "appointment_class.dart";
import "activity_class.dart";
import "vaccinations_class.dart";

class Pet{
  var name; //string
  var type; //string // cat or dog?
  var breed; //string
  var weight; //int

  // add in vaccinations, activity, appointments. The classes for these now exist just need to be implemented to be a part of the pat class
  List<Vaccinations> vaccinations = [];
  List<Activity> activities = [];
  List<Appointment> appointments = [];


  Pet(this.name, this.type, this.breed, this.weight);

  //setter for pet name
  setName(var _name){
    name = _name;
  }
  //setter for pet's type (only dog or cat) -> probably will be selected from a drop down menu or a button
  setType(var _type){
    type = _type;
  }
  //setter for pet's breed
  setBreed(var _breed){
    breed = _breed;
  }
  //setter for pet's current weight
  setWeight(var _weight){
    weight = _weight;
    
  }
  // Add a vaccination to the pet's record
  void addVaccination(Vaccinations vaccination) {
    vaccinations.add(vaccination);
  }

  // Add an activity to the pet's activity log
  void addActivity(Activity activity) {
    activities.add(activity);
  }

  // Add an appointment to the pet's appointment schedule
  void addAppointment(Appointment appointment) {
    appointments.add(appointment);
  }
}
//end of Pet class