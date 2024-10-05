import 'package:flutter/material.dart';

class FieldPage extends StatelessWidget {
  final String name;
  final String location;
  final String area;
  final String crop;
  final String date;

  FieldPage({
    Key? key,
    required this.name,
    required this.location,
    required this.area,
    required this.crop,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Location: $location'),
          ),
          ListTile(
            title: Text('Area: $area'),
          ),
          ListTile(
            title: Text('Crop: $crop'),
          ),
          ListTile(
            title: Text('Date: $date'),
          ),
        ],
      ),
    );
  }
}