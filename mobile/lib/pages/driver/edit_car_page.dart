import 'package:flutter/material.dart';
import 'package:mobile/helpers/fetch_status.dart';
import 'package:mobile/models/car_model.dart';
import 'package:mobile/pages/error_page.dart';
import 'package:mobile/services/car_service.dart';
import 'package:mobile/widgets/loading.dart';

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
  FetchStatus _fetchStatus = FetchStatus.loading;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _getCar();
  }

  void _getCar() async {
    try {
      final car = await _carService.get(widget.carId);
      setState(() {
        _makeController.text = car.make!;
        _modelController.text = car.model!;
        _registrationNumberController.text = car.registrationNumber!;
        _isActive = car.isActive!;
        _fetchStatus = FetchStatus.data;
      });
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
    }
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final updateCarModel = CreateCarModel(
        make: _makeController.text,
        model: _modelController.text,
        isActive: _isActive,
        registrationNumber: _registrationNumberController.text);
    CarModel? updatedCar;
    try {
      updatedCar = await _carService.update(widget.carId, updateCarModel);
      if (mounted) {
        Navigator.of(context).pop(updatedCar);
      }
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
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
        body: _build());
  }

  Widget _build() {
    switch (_fetchStatus) {
      case FetchStatus.loading:
        return const Loading();
      case FetchStatus.error:
        return const ErrorPage();
      default:
        return SingleChildScrollView(
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
        );
    }
  }
}
