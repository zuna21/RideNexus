import 'package:flutter/material.dart';
import 'package:mobile/widgets/cards/review_card.dart';
import 'package:mobile/widgets/rating.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recenzije"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Rating(rating: 4),
                Text("4.0",
                style: Theme.of(context).textTheme.titleLarge,),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("(48)"),
            const SizedBox(
              height: 20,
            ),
            const ReviewCard(),
          ],
        ),
      ),
    );
  }
}