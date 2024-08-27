import 'package:flutter/material.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/driver/driver_home_page.dart';
import 'package:mobile/services/driver_service.dart';

class DriverBasicAccountDetails extends StatefulWidget {
  const DriverBasicAccountDetails({super.key});

  @override
  State<DriverBasicAccountDetails> createState() =>
      _DriverBasicAccountDetailsState();
}

class _DriverBasicAccountDetailsState extends State<DriverBasicAccountDetails> {
  final _formKey = GlobalKey<FormState>();
  final _driverService = DriverService();

  bool _getDetails = false;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _priceController = TextEditingController();
  bool _hasPrice = false;

  @override
  void initState() {
    super.initState();
    getBasicDetails();
  }

  void getBasicDetails() async {
    try {
      final details = await _driverService.getBasicAccountDetails();
      setState(() {
        _getDetails = true;
        _firstNameController.text = details.firstName!;
        _lastNameController.text = details.lastName!;
        _phoneController.text = details.phone!;
        _priceController.text = details.price!.toString();
        _hasPrice = details.hasPrice!;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final accountDetails = DriverUpdateBasicDetailsModel();
    accountDetails.id = -1;
    accountDetails.firstName = _firstNameController.text;
    accountDetails.lastName = _lastNameController.text;
    accountDetails.phone = _phoneController.text;
    accountDetails.hasPrice = _hasPrice;
    accountDetails.price = double.tryParse(_priceController.text);

    bool isUpdated = false;
    try {
      isUpdated =
          await _driverService.updateBasicAccountDetails(accountDetails);
    } catch (e) {
      print(
        e.toString(),
      );
    }

    if (isUpdated && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const DriverHomePage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ažuriraj profil"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _getDetails
          ? SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ime',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Molimo unesite ime';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Prezime',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Molimo unesite prezime';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Telefon',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Molimo unesite broj telefona';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Želite li navesti cijenu?"),
                    Row(
                      children: [
                        Flexible(
                          child: RadioListTile<bool>(
                            title: const Text('Da'),
                            value: true,
                            groupValue: _hasPrice,
                            onChanged: (value) {
                              setState(() {
                                _hasPrice = value!;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<bool>(
                            title: const Text('Ne'),
                            value: false,
                            groupValue: _hasPrice,
                            onChanged: (value) {
                              setState(() {
                                _hasPrice = value!;
                                _priceController.text = "0";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      readOnly: !_hasPrice,
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cijena po kilometru',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Molimo unesite cijenu';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: _onSubmit,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        foregroundColor:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      child: const Text("Ažuriraj"),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: Text("Sačekajte..."),
            ),
    );
  }
}
