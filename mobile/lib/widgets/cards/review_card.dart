import 'package:flutter/material.dart';
import 'package:mobile/widgets/rating.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage("https://picsum.photos/500"),
                ),
                Text("zuna21", 
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer
                ),),
                const Rating(
                  rating: 3,
                  size: 10,
                )
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Flexible(
              child: Text(
                "Sve je bilo super, ali nam je na pola puta pukla guma :*.",
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
