import 'package:flutter/material.dart';
import 'package:mobile/models/car_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moja Vozila"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline),),
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
              ),
            ),
    );
  }
}
