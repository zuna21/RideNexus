import 'package:flutter/material.dart';
import 'package:mobile/models/car_model.dart';
import 'package:mobile/pages/driver/create_car_page.dart';
import 'package:mobile/services/car_service.dart';
import 'package:mobile/widgets/cards/car_card.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final carService = CarService();
  List<CarModel> cars = [];
  String? error;

  CarModel? createdCar;

  @override
  void initState() {
    super.initState();
    getCars();
  }

  Future<void> getCars() async {
    List<CarModel> retriveCars = [];
    String? errorText;
    try {
      retriveCars = await carService.getAll();
    } catch (e) {
      errorText = e.toString();
    }

    setState(() {
      cars = [...retriveCars];
      error = errorText;
    });
  }

  Future<void> onCreateNewCar() async {
    createdCar = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateCarPage(),
      ),
    );

    if (createdCar == null) return;
    setState(() {
      cars = [...cars, createdCar!];
    });
  }

  void onDeleteCar(int carId) {
    print(cars.length);
    cars.removeWhere((car) => car.id! == carId);
    print(cars.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moja Vozila"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            onPressed: onCreateNewCar,
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: error != null
          ? Center(
              child: Text(error!),
            )
          : ListView.builder(
              itemCount: cars.length,
              itemBuilder: (itemBuilder, index) => CarCard(
                car: cars[index],
                onDelete: onDeleteCar,
              ),
            ),
    );
  }
}
