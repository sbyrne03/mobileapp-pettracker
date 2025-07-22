// this file will be used to implement a style standard across the app

import 'package:flutter/material.dart';

// general app background color
const backgroundColor = Color.fromARGB(255, 252, 248, 244);

// standard button color
const buttonColor = Color.fromARGB(255, 225, 175, 100);


//universal appbar across pages
appBarUni(){
  return AppBar(
          backgroundColor: backgroundColor,
          // Profile button is on the far left
          leading: IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            onPressed: () {
              // navigate to profile page
            },
          ),
          // settings button is on the far right
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                // navigate to settings page
              },
            ),
          ]
  );
}



