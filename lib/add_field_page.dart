import 'package:agropulse/field.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

class AddFieldPage extends StatelessWidget {
  final Function(Field) onFieldAdded;
  GeocodingResult? location;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _ph = TextEditingController();
  final TextEditingController _soilState = TextEditingController();
  final TextEditingController _soilHumidity = TextEditingController();
  final TextEditingController _nitrogen = TextEditingController();
  final TextEditingController _phosphorus = TextEditingController();
  final TextEditingController _potassium = TextEditingController();
  final TextEditingController _area = TextEditingController();
  final TextEditingController _organicMatter = TextEditingController();
  Plant? _crop;

  AddFieldPage({Key? key, required this.onFieldAdded}) : super(key: key);

  void tryParseInputs(BuildContext context) {
    try {
      String name = _name.text;
      double ph = double.parse(_ph.text);
      int soilState = int.parse(_soilState.text);
      int soilHumidity = int.parse(_soilHumidity.text);
      double nitrogen = double.parse(_nitrogen.text);
      double phosphorus = double.parse(_phosphorus.text);
      int potassium = int.parse(_potassium.text);
      int area = int.parse(_area.text);
      double organicMatter = double.parse(_organicMatter.text);

      Plant crop = _crop!;
      Field field = Field(
        name: name,
        soil: Stats(
          organicMatter: organicMatter,
          ph: ph,
          soilState: soilState,
          humidity: soilHumidity,
          nitrogen: nitrogen,
          phosphorus: phosphorus,
          potassium: potassium,
        ),
        area: area,
        cropType: crop,
        location: location!,
      );
      onFieldAdded(field);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please check your inputs and try again')),
      );
    }
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
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: double.infinity,
                  child: MapLocationPicker (
                    apiKey: "AIzaSyCUdvrpjxt148BXxWWo3wmRay6vZcsI0J8",
                    onNext: (GeocodingResult? result) {
                      location = result;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Field Name',
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _area,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  labelText: 'Area',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ph,
                        decoration: const InputDecoration(
                          labelText: 'pH',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _soilState,
                        decoration: const InputDecoration(
                          labelText: 'Soil State',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _soilHumidity,
                        decoration: const InputDecoration(
                          labelText: 'Soil Humidity',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _nitrogen,
                        decoration: const InputDecoration(
                          labelText: 'Nitrogen',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _phosphorus,
                        decoration: const InputDecoration(
                          labelText: 'Phosphorus',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _potassium,
                        decoration: const InputDecoration(
                          labelText: 'Potassium',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _organicMatter,
                        decoration: const InputDecoration(
                          labelText: 'Organic Matter',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SelectCrop(
                        onCropSelected: (Plant? crop) {
                          _crop = crop;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        textStyle: const TextStyle(fontSize: 16),
                        maximumSize: const Size(120, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () {
                      Navigator.pop(context);
                      },
                      child: const Text('Back', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        textStyle: const TextStyle(fontSize: 16),
                        maximumSize: const Size(120, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () {
                        tryParseInputs(context);
                      },
                      child: const Text('Add Field', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectCrop extends StatefulWidget {
  final Function(Plant?) onCropSelected;

  SelectCrop({Key? key, required this.onCropSelected}) : super(key: key);

  @override
  _SelectCropState createState() => _SelectCropState();
}

class _SelectCropState extends State<SelectCrop> {
  Plant? _crop;

  void _handleCropSelected(Plant? crop) {
    setState(() {
      _crop = crop;
    });
    widget.onCropSelected(crop);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Plant>(
      value: _crop,
      isExpanded: true,
      items: Plant.values.map((Plant plant) {
        return DropdownMenuItem<Plant>(
          value: plant,
          child: Container(
            height: 100, // Increase the height of the dropdown items
            alignment: Alignment.center,
            child: Text(plant.toString().split('.').last, style: Theme.of(context).textTheme.bodyLarge,),
          ),
        );
      }).toList() + [DropdownMenuItem<Plant>(
        value: null,
        child: Text('Select Crop', style: Theme.of(context).textTheme.bodyLarge,),
      )],
      onChanged: _handleCropSelected,
    );
  }
}