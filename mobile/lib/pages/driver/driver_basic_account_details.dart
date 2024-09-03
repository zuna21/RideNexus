import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/helpers/fetch_status.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/driver/driver_home_page.dart';
import 'package:mobile/pages/driver/driver_username_password_page.dart';
import 'package:mobile/pages/error_page.dart';
import 'package:mobile/services/driver_service.dart';
import 'package:mobile/services/photo_service.dart';
import 'package:mobile/widgets/loading.dart';

class DriverBasicAccountDetails extends StatefulWidget {
  const DriverBasicAccountDetails({super.key});

  @override
  State<DriverBasicAccountDetails> createState() =>
      _DriverBasicAccountDetailsState();
}

class _DriverBasicAccountDetailsState extends State<DriverBasicAccountDetails> {
  FetchStatus _fetchStatus = FetchStatus.loading;
  final _formKey = GlobalKey<FormState>();
  final _driverService = DriverService();
  final _priceController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _photoService = PhotoService();

  bool _hasPrice = false;
  String? _profilePhotoNetwork;
  File? _profilePhotoFile;
  bool _isFormChanged = false;

  @override
  void initState() {
    super.initState();
    getBasicDetails();
  }

  void getBasicDetails() async {
    try {
      final details = await _driverService.getBasicAccountDetails();
      setState(() {
        _firstNameController.text = details.firstName!;
        _lastNameController.text = details.lastName!;
        _phoneController.text = details.phone!;
        _priceController.text = details.price!.toString();
        _hasPrice = details.hasPrice!;
        _profilePhotoNetwork = details.imageUrl;
        _profilePhotoFile = null;

        _fetchStatus = FetchStatus.data;
      });
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
    }
  }

  void _uploadPhoto() async {
    try {
      final photo = await _photoService.getImageFromGallery();
      setState(() {
        _profilePhotoFile = photo;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _submitPhoto() async {
    if (_profilePhotoFile == null) return;
    try {
      final photo = await _photoService.uploadDriverProfile(_profilePhotoFile!);
      setState(() {
        _profilePhotoFile = null;
        _profilePhotoNetwork = photo.imageUrl;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _deleteProfile() async {
    if (_profilePhotoNetwork == null) return;

    try {
      await _photoService.deleteDriverProfile();
      setState(() {
        _profilePhotoFile = null;
        _profilePhotoNetwork = null;
      });
    } catch (e) {
      print(
        e.toString(),
      );
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
    accountDetails.imageUrl = _profilePhotoNetwork;
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
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const DriverUsernamePasswordPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  child: const Text("Korisničko ime i lozinka"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Osnovni Podaci"),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      minRadius: 100,
                      backgroundImage: _profilePhotoFile != null
                          ? FileImage(_profilePhotoFile!)
                          : NetworkImage(
                              _profilePhotoNetwork ?? AppConfig.defaultProfile),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _uploadPhoto,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          child: const Text("Postavi"),
                        ),
                        ElevatedButton(
                          onPressed:
                              _profilePhotoFile != null ? _submitPhoto : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          child: const Text("Objavi"),
                        ),
                        ElevatedButton(
                          onPressed: _profilePhotoNetwork != null
                              ? _deleteProfile
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Izbrisi"),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _firstNameController,
                        onChanged: (value) {
                          setState(() {
                            _isFormChanged = true;
                          });
                        },
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
                        onChanged: (value) {
                          setState(() {
                            _isFormChanged = true;
                          });
                        },
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
                  onChanged: (value) {
                    setState(() {
                      _isFormChanged = true;
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      _isFormChanged = true;
                    });
                  },
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
                  onPressed: _isFormChanged ? _onSubmit : null,
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
        );
    }
  }
}
