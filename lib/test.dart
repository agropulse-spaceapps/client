import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

void main () {
  runApp( MaterialApp(
    home: Scaffold(
      body: MapLocationPicker (
        apiKey: "AIzaSyCUdvrpjxt148BXxWWo3wmRay6vZcsI0J8",
        onNext: (GeocodingResult? result) {
          print(result);
        },
        mapStyle: "Satellite",
      ),
    ),
  ));
}