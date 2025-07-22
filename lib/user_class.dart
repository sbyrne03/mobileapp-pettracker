// This is the class that stores the user info. it does not currently have a page but wouold be useful if a login screen and accounts want to be implemented. A user profile page was not in original documentation so it is not added currently
import 'package:flutter/material.dart';

class User 
{
  var name; // string
  var email; // string
  var login; // string
  Map <String, bool> settings;
 
  User({this.name, this.email, this.login, this.settings = const {}}); // constructor 

  //setter for name
  setName(var name)
  {
    name = name;
  }
  // setter for email
  setEmail(var email)
  {
    email = email;
  }
  // setter for login
  setLogin(var login)
  {
    login = login;
  }
  // setter for settings
 setSettings(Map <String, bool> settings)
 {
  settings = settings;
 }
} // end of user class
