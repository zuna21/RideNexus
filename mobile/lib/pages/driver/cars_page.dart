import 'package:flutter/material.dart';
import 'package:mobile/helpers/fetch_status.dart';
import 'package:mobile/models/car_model.dart';
import 'package:mobile/pages/driver/create_car_page.dart';
import 'package:mobile/pages/driver/edit_car_page.dart';
import 'package:mobile/pages/error_page.dart';
import 'package:mobile/services/car_service.dart';
import 'package:mobile/widgets/cards/car_card.dart';
import 'package:mobile/widgets/dialogs/confirmation_dialog.dart';
import 'package:mobile/widgets/loading.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final carService = CarService();
  FetchStatus _fetchStatus = FetchStatus.loading;
  List<CarModel> _cars = [];

  CarModel? createdCar;

  @override
  void initState() {
    super.initState();
    _getCars();
  }

  void _getCars() async {
    List<CarModel> retriveCars = [];
    try {
      retriveCars = await carService.getAll();
      setState(() {
        _cars = [...retriveCars];
        _fetchStatus = FetchStatus.data;
      });
    } catch (e) { 
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
    }
  }

  void _onCardTap(int carId) async {
    final updatedCar = await Navigator.of(context).push<CarModel?>(
      MaterialPageRoute(
        builder: (_) => EditCarPage(carId: carId),
      ),
    );

    if (updatedCar != null) {
      setState(() {
        _cars[_cars.indexWhere((c) => c.id == carId)] = updatedCar;
      });
    }
  }

  Future<void> onCreateNewCar() async {
    createdCar = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateCarPage(),
      ),
    );

    if (createdCar == null) return;
    setState(() {
      _cars = [..._cars, createdCar!];
    });
  }

  Future<void> _deleteCar(int carId) async {
    int? deletedCar;
    try {
      deletedCar = await carService.delete(carId);
      setState(() {
        _cars.removeWhere((car) => car.id! == deletedCar!);
      });
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
        title: const Text("Moja Vozila"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            onPressed: onCreateNewCar,
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: _build(),
    );
  }

  Widget _build() {
    switch (_fetchStatus) {
      case FetchStatus.loading:
        return const Loading();
      case FetchStatus.error:
        return const ErrorPage();
      default:
        return ListView.builder(
          itemCount: _cars.length,
          itemBuilder: (itemBuilder, index) => Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _deleteCar(_cars[index].id!),
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (_) => const ConfirmationDialog(),
              );
            },
            child: CarCard(
              car: _cars[index],
              onCardTap: _onCardTap,
            ),
          ),
        );
    }
  }
}
