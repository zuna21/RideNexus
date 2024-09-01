import 'package:flutter/material.dart';
import 'package:mobile/models/car_model.dart';
import 'package:mobile/services/car_service.dart';

class EditCarPage extends StatefulWidget {
  const EditCarPage({super.key, required this.carId});

  final int carId;

  @override
  State<EditCarPage> createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  final _formKey = GlobalKey<FormState>();
  final _carService = CarService();

  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  bool _isActive = false;
  bool _haveCar = false;

  @override
  void initState() {
    super.initState();
    getCar();
  }

  void getCar() async {
    try {
      final car = await _carService.get(widget.carId);
      setState(() {
        _makeController.text = car.make!;
        _modelController.text = car.model!;
        _registrationNumberController.text = car.registrationNumber!;
        _isActive = car.isActive!;
        _haveCar = true;
      });
    } catch(e) {
      print(e.toString(),);
    }
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final updateCarModel = CreateCarModel(
      make: _makeController.text,
      model: _modelController.text,
      isActive: _isActive,
      registrationNumber: _registrationNumberController.text
    );
    CarModel? updatedCar;
    try {
      updatedCar = await _carService.update(widget.carId, updateCarModel);
    } catch(e) {
      print(e.toString(),);
    }

    if (mounted) {
      Navigator.of(context).pop(updatedCar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ažuriraj"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: _haveCar
      ? SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _makeController,
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
                    controller: _modelController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Model',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Molimo unesite model vozila';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _registrationNumberController,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 8),
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
              onPressed: _onSubmit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              child: const Text("Ažurirajte"),
            ),
          ],
        ),
      )
      : const Center(
        child: Text("Sačekajte..."),
      ),
    );
  }
}
