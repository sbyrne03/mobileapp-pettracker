import 'package:flutter/material.dart';

splashScreen() {
  MaterialApp(
      title: "Splash Screen",
      home: Scaffold(
        // using Stack widget to overlay the pay print onto the gradient
        body: Stack(
          children: <Widget>[
            //background picture takes up the whole screen
            const Center(
              child: Image(
                image: AssetImage('assets/splashscreen_background.png'),
                fit: BoxFit.cover, //cover whole page
                width: double.infinity, //no height or width limit
                height: double.infinity,
              ),
            ),
            // pawprint stays in the center
            Container(
                // insets makes the paw print smaller
                padding: const EdgeInsets.all(150),
                child: const Center(
                  child: Image(image: AssetImage('assets/pawprint_asset.png')),
                )),
          ],
        ),
      ));
}
