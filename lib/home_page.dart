import 'package:agropulse/add_field_page.dart';
import 'package:agropulse/field.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

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
        location: GeocodingResult(
          formattedAddress: 'Istanbul, Turkey',
          placeId: '1',
          geometry: Geometry(
            location: Location(
              lat: 41.0082,
              lng: 28.9784,
            ),
          ),
        ),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Text('AgroPulse'),
            Spacer()
          ],
        ),
        centerTitle: false,
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  minimumSize: const Size(double.infinity, 80)
                ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_circle_outline, size: 28, color: Colors.black,),
                    Text('  Add Field', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: fields.length,
                  itemBuilder: (field, index) {
                    return FieldView(field: fields[index]);
                  },
                ),
              ),
            ],
          ),
        ),
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
    return InkWell(
      onTap: null,
      child: Card(
        color: Colors.grey[300],
        child: Container(
          height: 80,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(field.name, style: Theme.of(context).textTheme.bodyLarge),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Crop: ${field.crop!.name}'),
                  const Spacer(),
                  Text('Area: ${field.area}m²'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}