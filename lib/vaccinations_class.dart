// This class is made so that the app can store vaccination data. This is one of the things that we decided was out of the scope of the main priorities of the project and does not have a screen attached currently
// it is here if another group feels it is necessary to implement or gets to the part in the schedule where additional things can be added

import 'package:flutter/material.dart';

class Vaccinations {
  var vaccinationType; // string
  List<String> vaccinationRecord;
  var needsVaccine; // bool

  Vaccinations(
      {this.vaccinationType,
      this.vaccinationRecord = const [],
      this.needsVaccine = false}); // constructor

  // setters for all variables
  // setter for vaccination type
  setVaccinationType(var vaccinationType) {
    vaccinationType = vaccinationType;
  }

  // setter for needsVaccine
  setNeedsVaccine(var needsVaccine) {
    needsVaccine = needsVaccine;
  }

  // setter for vaccination records
  setVaccinationRecords(var vaccinationRecord) {
    vaccinationRecord = vaccinationRecord;
  }
}
