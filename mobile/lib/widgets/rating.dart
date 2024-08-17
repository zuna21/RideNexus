import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

class Rating extends StatefulWidget {
  final double rating;
  final bool canChange;
  final double size;
  final Function(double)? onChange;

  const Rating({
    super.key, 
    required this.rating, 
    this.size = 48,
    this.canChange = true,
    this.onChange
    });

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double currentRating = 0;
  double size = 0;

  @override
  void initState() {
    super.initState();
    currentRating = widget.rating;
    size = widget.size;
  }

  @override
  Widget build(BuildContext context) {
    return PannableRatingBar(
      rate: currentRating,
      items: List.generate(
          5,
          (index) => RatingWidget(
                selectedColor: Colors.yellow,
                unSelectedColor: Colors.grey,
                child: Icon(
                  Icons.star,
                  size: size,
                ),
              )),
      onChanged: (value) {
        if (!widget.canChange) return;
        setState(() {
          currentRating = value;
          if (widget.onChange != null) {
            // print(currentRating);
            widget.onChange!(currentRating);
          }
        });
      },
    );
  }
}
