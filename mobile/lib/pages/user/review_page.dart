import 'package:flutter/material.dart';
import 'package:mobile/widgets/rating.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ostavi ocjenu"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.secondaryContainer),
                      child: Row(
                        children: [
                          const Text("Anonimno"),
                          Radio(
                              value: true, groupValue: true, onChanged: (value) {}),
                          const Spacer(),
                          const Text("Javno"),
                          Radio(
                              value: false,
                              groupValue: true,
                              onChanged: (value) {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text("Povuci za ocjenu"),
                    const Rating(rating: 0),
                    const SizedBox(
                      height: 50,
                    ),
                    const TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '(Nije obavezno) Ostavite komentar...',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onTertiaryContainer,
              ),
              child: const Text("Objavi"),
            ),
          ],
        ),
      ),
    );
  }
}
