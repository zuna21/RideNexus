import 'package:flutter/material.dart';
import 'package:mobile/models/car_model.dart';
import 'package:mobile/pages/driver/create_car_page.dart';
import 'package:mobile/services/car_service.dart';
import 'package:mobile/widgets/cards/car_card.dart';
import 'package:mobile/widgets/dialogs/confirmation_dialog.dart';

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


  Future<void> _deleteCar(int carId) async {
    int? deletedCar;
    String? errorText;
    try {
      deletedCar = await carService.delete(carId);
    } catch(e) {
      errorText = e.toString();
    }

    if (deletedCar != null) {
      setState(() {
        cars.removeWhere((car) => car.id! == deletedCar!);
      });
    } else {
      setState(() {
        error = errorText;
      });
    }
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
              itemBuilder: (itemBuilder, index) => Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => _deleteCar(cars[index].id!),
                confirmDismiss: (direction) {
                  return showDialog(context: context, builder: (builder) => const ConfirmationDialog(),);
                },
                child: CarCard(
                  car: cars[index],
                ),
              ),
            ),
    );
  }
}
