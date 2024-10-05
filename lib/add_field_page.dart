import 'package:agropulse/field.dart';
import 'package:flutter/material.dart';

class AddFieldPage extends StatelessWidget {
  final Function(Field) onFieldAdded;

  const AddFieldPage({Key? key, required this.onFieldAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Row(
          children: [
            Text('AgroPulse'),
            Spacer()
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add field
            },
            child: const Text('Add Field'),
          ),
        ],
      ),
    );
  }
}