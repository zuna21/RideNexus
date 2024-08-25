import 'package:flutter/material.dart';

class FinishRidePage extends StatelessWidget {
  const FinishRidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Završite Vožnju"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                  "Nadamo se da je vožnja prošla kako treba. Ukoliko želite možete zamoliti putnika da Vam ostavi pozitivnu ocjenu. Ispod možete ostaviti koliko je vožnja koštala ukoliko to želite (nije obavezno, to je samo ako želite voditi evidenciju da imate uvid kad god to želite)."),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cijena (nije obavezno)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
              child: const Text("Završi"),
            ),
          ],
        ),
      ),
    );
  }
}
