import 'package:flutter/material.dart';
import 'package:mobile/models/car_model.dart';
import 'package:mobile/services/car_service.dart';

class CreateCarPage extends StatefulWidget {
  const CreateCarPage({super.key});

  @override
  State<CreateCarPage> createState() => _CreateCarPageState();
}

class _CreateCarPageState extends State<CreateCarPage> {
  final _formKey = GlobalKey<FormState>();
  final _make = TextEditingController();
  final _model = TextEditingController();
  final _registrationNumber = TextEditingController();
  final carService = CarService();

  CreateCarModel car = CreateCarModel();
  bool _isActive = true;
  CarModel? createdCar;

  @override
  void dispose() {
    _make.dispose();
    _model.dispose();
    _registrationNumber.dispose();
    super.dispose();
  }

  Future<void> create() async {
    if(!_formKey.currentState!.validate()) return;
    car.make = _make.text;
    car.model = _model.text;
    car.registrationNumber = _registrationNumber.text;
    car.isActive = _isActive;

    try{
      createdCar = await carService.create(car);
    } catch(ex) {
      print(ex);
    }

    if (createdCar != null && mounted) {
      Navigator.of(context).pop(createdCar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kreiraj vozilo"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _make,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Marka',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Molimo unesite vrstu vozila';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _model,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Model',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Molimo unesite vrstu vozila';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _registrationNumber,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tablice',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Molimo unesite vrstu vozila';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Da li je to vozilo sa kojim radite?"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    child: Row(
                      children: [
                        const Text("Da"),
                        Radio(
                            value: true,
                            groupValue: _isActive,
                            onChanged: (value) {
                              setState(() {
                                _isActive = value!;
                              });
                            }),
                        const Spacer(),
                        const Text("Ne"),
                        Radio(
                            value: false,
                            groupValue: _isActive,
                            onChanged: (value) {
                              setState(() {
                                _isActive = value!;
                              });
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: create,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              child: const Text("Kreiraj"),
            ),
          ],
        ),
      ),
    );
  }
}
