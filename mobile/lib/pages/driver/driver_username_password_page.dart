import 'package:flutter/material.dart';
import 'package:mobile/services/driver_service.dart';

class DriverUsernamePasswordPage extends StatefulWidget {
  const DriverUsernamePasswordPage({super.key});

  @override
  State<DriverUsernamePasswordPage> createState() => _DriverUsernamePasswordPageState();
}

class _DriverUsernamePasswordPageState extends State<DriverUsernamePasswordPage> {
  final _driverService = DriverService();
  bool _getDetails = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _repeatNewPasswordController = TextEditingController();
  bool _changePassword = false;

  @override
  void initState() {
    super.initState();
    _getMainDetails();
  }

  void _getMainDetails() async {
    try {
      final response = await _driverService.getMainAccountDetails();
      setState(() {
        _usernameController.text = response.username!;
        _getDetails = true;
      });
    } catch(e) {
      print(e.toString());
    }
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: const Text("Korisničko ime i lozinka"),
      ),
      body: _getDetails
      ? SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 8.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Korisničko ime',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite korisničko ime';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Želite li navesti promijeniti lozinku?"),
              Row(
                children: [
                  Flexible(
                    child: RadioListTile<bool>(
                      title: const Text('Da'),
                      value: true,
                      groupValue: _changePassword,
                      onChanged: (value) {
                        setState(() {
                          _changePassword = value!;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile<bool>(
                      title: const Text('Ne'),
                      value: false,
                      groupValue: _changePassword,
                      onChanged: (value) {
                        setState(() {
                          _changePassword = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _oldPasswordController,
                readOnly: !_changePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Stara lozinka',
                ),
                validator: (value) {
                  if (_changePassword && (value == null || value.isEmpty)) {
                    return 'Molimo unesite staru lozinku';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _newPasswordController,
                readOnly: !_changePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nova lozinka',
                ),
                validator: (value) {
                  if (_changePassword && (value == null || value.isEmpty)) {
                    return 'Molimo unesite novu lozinku';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _repeatNewPasswordController,
                readOnly: !_changePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ponovite novu lozinku',
                ),
                validator: (value) {
                  if ((_changePassword && (value == null || value.isEmpty)) ||
                  (_changePassword && (value != _newPasswordController.text))) {
                    return 'Molimo ponovite tačno novu lozinku';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                child: const Text("Ažurirajte"),
              ),
            ],
          ),
        ),
      )
      : const Center(
        child: Text("Sacekajte..."),
      ),
    );
  }
}
