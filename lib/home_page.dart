import 'package:agropulse/add_field_page.dart';
import 'package:agropulse/field.dart';
import 'package:agropulse/field_page.dart';
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
      Field (
        name: "Fasulye Tarlası", 
        soil: Stats(
          ph: 6.5, 
          soilState: 12, 
          humidity: 45, 
          nitrogen: 20.0, 
          phosphorus: 15.0, 
          potassium: 15, 
          organicMatter: 5.0
        ), 
        area: 1280, 
        location: GeocodingResult(
          placeId: "Istanbul",
          geometry: Geometry(
            location: Location(
              lat: 41.0082, 
              lng: 28.9784
            )
          )
        ),
        cropType: Plant.beans,
      ),
      Field(
        name: "Buğday Tarlası",
        soil: Stats(
          ph: 7.0,
          soilState: 10,
          humidity: 50,
          nitrogen: 25.0,
          phosphorus: 20.0,
          potassium: 20,
          organicMatter: 6.0,
        ),
        area: 1500,
        location: GeocodingResult(
          placeId: "Ankara",
          geometry: Geometry(
            location: Location(
              lat: 39.9334,
              lng: 32.8597,
            ),
          ),
        ),
        cropType: Plant.wheat,
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
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0, left: 16),
                    child: Text('AgroPulse', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  const Spacer()
                ],
              ),
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
              const SizedBox(height: 18),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('My fields', style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  const Spacer(),
                  const Icon(Icons.edit, size: 36, color: Colors.black,),
                ],
              ),
              const SizedBox(height: 18),
              ColoredBox(color: Colors.grey[500]!, child: SizedBox(height: 3, width: MediaQuery.of(context).size.width * 0.9),),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.builder(
                  itemCount: fields.length,
                  itemBuilder: (field, index) {
                    return Column(
                      children: [
                        FieldView(field: fields[index]),
                        const SizedBox(height: 8),
                        ColoredBox(color: Colors.grey[500]!, child: SizedBox(height: 2, width: MediaQuery.of(context).size.width * 0.7),),
                        const SizedBox(height: 8),
                      ],
                    );
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FieldPage(field: field),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        child: Container(
          height: 80,
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(field.name, style: Theme.of(context).textTheme.bodyLarge),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Crop: ${field.cropType!.name}'),
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