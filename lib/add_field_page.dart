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
  Plant? _crop;

  AddFieldPage({Key? key, required this.onFieldAdded}) : super(key: key);

  void tryParseInputs(BuildContext context) {
    try {
      print(_name.text);
      print(_ph.text);
      print(_soilState.text);
      print(_soilHumidity.text);
      print(_nitrogen.text);
      print(_phosphorus.text);
      print(_potassium.text);
      print(_area.text);
      print(_crop);

      String name = _name.text;
      double ph = double.parse(_ph.text);
      int soilState = int.parse(_soilState.text);
      int soilHumidity = int.parse(_soilHumidity.text);
      double nitrogen = double.parse(_nitrogen.text);
      double phosphorus = double.parse(_phosphorus.text);
      int potassium = int.parse(_potassium.text);
      int area = int.parse(_area.text);
      Plant crop = _crop!;
      Field field = Field(
        name: name,
        ph: ph,
        soilState: soilState,
        soilHumidity: soilHumidity,
        nitrogen: nitrogen,
        phosphorus: phosphorus,
        potassium: potassium,
        area: area,
        crop: crop,
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
                TextField(
                  controller: _area,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  labelText: 'Area',
                  ),
                ),
                const SizedBox(height: 24),
                SelectCrop(
                  onCropSelected: (Plant? crop) {
                    _crop = crop;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                      Navigator.pop(context);
                      },
                      child: const Text('Back', style: TextStyle(color: Colors.white)),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        tryParseInputs(context);
                      },
                      child: const Text('Add Field', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
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
          child: Text(plant.toString().split('.').last),
        );
      }).toList() + [const DropdownMenuItem<Plant>(
        value: null,
        child: Text('Select Crop'),
      )],
      onChanged: _handleCropSelected,
    );
  }
}