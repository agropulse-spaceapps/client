import 'package:agropulse/field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <Field>? fields;

  @override
  void initState() {
    super.initState();
    fields = [
      Field(
        name: 'Field 1',
        location: 'Location 1',
        area: 'Area 1',
        crop: 'Crop 1',
        date: 'Date 1',
      ),
      Field(
        name: 'Field 2',
        location: 'Location 2',
        area: 'Area 2',
        crop: 'Crop 2',
        date: 'Date 2',
      ),
      Field(
        name: 'Field 3',
        location: 'Location 3',
        area: 'Area 3',
        crop: 'Crop 3',
        date: 'Date 3',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroPulse'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
              fields!.add(
                Field(
                name: 'New Field',
                location: 'New Location',
                area: 'New Area',
                crop: 'New Crop',
                date: 'New Date',
                ),
              );
              });
            },
            child: const Text('Add Field'),
            ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: fields!.length,
              itemBuilder: (field, index) {
                return FieldView(field: fields![index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FieldView extends StatelessWidget {
  final Field field;

  FieldView({
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(field.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(field.location),
            Text(field.area),
            Text(field.crop),
            Text(field.date),
          ],
        ),
      ),
    );
  }
}