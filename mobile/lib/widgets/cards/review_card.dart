import 'package:flutter/material.dart';
import 'package:mobile/models/review_model.dart';
import 'package:mobile/widgets/rating.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewCardModel review;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage("https://picsum.photos/500"),
                ),
                Text(review.username!, 
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer
                ),),
                Rating(
                  rating: review.rating!,
                  canChange: false,
                  size: 10,
                )
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Flexible(
              child: Text(
                review.comment!,
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
