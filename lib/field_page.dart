import 'package:agropulse/field.dart';
import 'package:flutter/material.dart';

class FieldPage extends StatelessWidget {
  final Field field;

  FieldPage({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(field.name),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Location: ${field.location.addressComponents}'),
          ),
          ListTile(
            title: Text('Area: ${field.area} m²'),
          ),
          ListTile(
            title: Text('Crop: ${field.cropType!.name}'),
          ),
        ],
      ),
    );
  }
}