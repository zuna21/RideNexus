import 'package:flutter/material.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/driver/driver_permissions_page.dart';
import 'package:mobile/pages/driver/driver_register_page.dart';
import 'package:mobile/services/driver_service.dart';

class DriverLoginPage extends StatefulWidget {
  const DriverLoginPage({super.key});

  @override
  State<DriverLoginPage> createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _driverService = DriverService();
  final driverLogin = LoginDriverModel();

  bool _hidePassword = true;
  bool _isLoading = false;
  DriverModel? driver;

  void _onLogin() async {
    if (!_formKey.currentState!.validate()) return;
    driverLogin.username = _usernameController.text;
    driverLogin.password = _passwordController.text;
    setState(() {
      _isLoading = true;
    });
    try {
      driver = await _driverService.login(driverLogin);
      if (driver != null && mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const DriverPermissionsPage(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Korisničko ime ili lozinka nisu tačni."))
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vozač"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const DriverRegisterPage(),
              ),
            ),
            child: const Text("Kreiraj profil"),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Dobrodošli",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 50,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Korisničko ime',
                      suffixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Molimo unesite korisničko ime';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Lozinka',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Molimo unesite lozinku';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ukoliko nemate profil kliknite na \"Kreiraj profil\" u gornjem desnom uglu",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                  ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                  : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      foregroundColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    onPressed: _onLogin,
                    child: const Text("Prijavi se"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
