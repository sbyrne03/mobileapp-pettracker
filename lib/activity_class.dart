// This class is where the dzata for the activities the pet does is stored

// import 'package:flutter/material.dart'; // not using

class Activity {
  var activityName; // String
  var activityType; // String, this could maybe be a map of the of the activity options?
  var activityDesc; // String, holds description of the activity
  var activityDate;

  Activity(
      {this.activityName,
      this.activityType,
      this.activityDesc, 
      this.activityDate});


  //getter for activity type
  String getActivityType(){
    return activityType;
  }

  // setters for all variables, will be used if the ability to edit activities is implemented
  // setter for activity name
  setActivityName(var activityName) {
    activityName = activityName;
  }

  // setter for activity type
  setActivityType(var activityType) {
    activityType = activityType;
  }

  // setter for activity description
  setActivityDesc(var _activityDesc) {
    activityDesc = _activityDesc;
  }

  // setter for activity date
  setActivityDate(var _activityDate) {
    activityDate = _activityDate;
  }
}
