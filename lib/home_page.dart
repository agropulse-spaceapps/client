import 'package:agropulse/add_field_page.dart';
import 'package:agropulse/field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <Field> fields = [];

  @override
  void initState() {
    super.initState();
    fields = [ // get with mongoDB
      Field(
        name: 'Field of bananas',
        area: 999,
        crop : Plant.banana, 
        ph: 6.5,
        soilState: 1,
        soilHumidity: 1,
        nitrogen: 1.5,
        phosphorus: 1.5,
        potassium: 1,
      ),
    ];
  }

  void addField(Field field) { // update with mongoDB
    setState(() {
      fields.add(field);
    });
  }

  void eraseField(Field field) { // update with mongoDB
    setState(() {
      fields.add(field);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFieldPage(
                      onFieldAdded: (newField) {
                        addField(newField);
                      },
                    ),
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
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Area: ${field.area} sqm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}