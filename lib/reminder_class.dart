// This reminder class is meant to hold the content of reminders the user creates through the reminder screen. 
// It will also be used to output reminders onto the home screen. Reminders will most likely be held in a list
// for easy access and ordered based on the date/time that they are due. 

// Attributes: name is the variable holding what the user wants to be reminded of, date will be the date the
// reminder needs to be completed by, time is the time that the reminder needs to be completed by, complete
// will hold a boolean value of whether or not the reminder has been completed. Somehow 
// reminders will get deleted once they are completed, maybe at the end of the day. 

// Methods: contructor gives user input values for the name and date starts the task as incomplete. 
// completeReminder() will change the complete value from false to true. 
// The rest are setters for editing the values after the user creates the reminder. 

class Reminder {
  String name; //string
  String desc; //string 
  int year; //string (to possibly be used later for push notifications)
  int month; //string (to possibly be used later for push notifications)
  int day;
  bool? complete = false; //every task starts as incomplete

  Reminder(this.name, this.desc, this.year, this.month, this.day);
  
  //completeReminder() changes the value of complete to make it true. True = completed
  completeReminder(){
    complete = true;
    return complete;
  }
  //setter for name value
  setName(var _name){
    name = _name;
  }
  //setter for year value
  setYear(var _year){
    year = _year;
  }

  //setter for month value
  setMonth(var _month){
    month = _month;
  }

  //setter for dayvalue
  setDay(var _day){
    day = _day;
  }
}
// end of Reminder class