import 'package:flutter/material.dart';
import 'package:mobile/helpers/permission_service.dart';
import 'package:mobile/pages/driver/driver_home_page.dart';
import 'package:mobile/pages/user/user_home_page.dart';
import 'package:mobile/user_service.dart';

class DriverPermissionsPage extends StatefulWidget {
  const DriverPermissionsPage({super.key});

  @override
  State<DriverPermissionsPage> createState() => _DriverPermissionsPageState();
}

class _DriverPermissionsPageState extends State<DriverPermissionsPage> {
  final _permissionService = PermissionService();
  final _userService = UserService();

  @override
  void initState() {
    super.initState();
    _givePermissions();
  }

  void _givePermissions() async {
    final havePermissions =
        await _permissionService.requestPermissions(context);
    final role = await _userService.getRole();
    
    if (havePermissions && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => role == "driver"
          ? const DriverHomePage()
          : const UserHomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Dozvole"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Column(
                  children: [
                    Text(
                      "Obavještenje o Dozvolama",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Da bismo vam pružili najbolje moguće iskustvo i funkcionalnost aplikacije, potrebne su nam određene dozvole na vašem uređaju. Konkretno, aplikacija zahtijeva sljedeće:",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        "1. Dozvolu za Pristup Lokaciji: Ova dozvola omogućava nam da koristimo vašu lokaciju kako bismo vam pružili personalizirane usluge i tačne informacije bazirane na vašem trenutnom mjestu.",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        "2. Dozvolu za Primanje Notifikacija: Ova dozvola nam omogućava da vam šaljemo važne obavijesti, ažuriranja i poruke direktno na vaš uređaj, kako biste bili u toku sa svim relevantnim informacijama i novostima vezanim za našu aplikaciju.",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ),
                    Text(
                      "Vaša privatnost i sigurnost su nam na prvom mjestu, i sve informacije koje prikupimo biće tretirane sa najvećom pažnjom i u skladu sa važećim propisima o zaštiti podataka.",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Molimo vas da omogućite ove dozvole kako bismo mogli da vam pružimo optimalno korisničko iskustvo. Ako imate bilo kakvih pitanja ili nedoumica, slobodno nas kontaktirajte putem naših kontakt informacija unutar aplikacije.",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Hvala na razumijevanju i saradnji!",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _givePermissions,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onTertiaryContainer,
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text("Daj dozvole"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
