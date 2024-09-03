import 'package:flutter/material.dart';
import 'package:mobile/helpers/fetch_status.dart';
import 'package:mobile/models/review_model.dart';
import 'package:mobile/pages/error_page.dart';
import 'package:mobile/services/review_service.dart';
import 'package:mobile/widgets/cards/review_card.dart';
import 'package:mobile/widgets/loading.dart';
import 'package:mobile/widgets/rating.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key, required this.driverId});

  final int driverId;

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  FetchStatus _fetchStatus = FetchStatus.loading;
  final _reviewService = ReviewService();
  ReviewDetailsModel? _review;

  @override
  void initState() {
    super.initState();
    getReviewDetails();
  }

  void getReviewDetails() async {
    ReviewDetailsModel? review;
    try {
      review = await _reviewService.getReviewDetails(widget.driverId);
      setState(() {
        _review = review;
        _fetchStatus = FetchStatus.data;
      });
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recenzije"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _build()
    );
  }


  Widget _build() {
    switch (_fetchStatus) {
      case FetchStatus.loading:
        return const Loading();
      case FetchStatus.error:
        return const ErrorPage();
      default:
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Rating(
                        rating: _review!.rating!,
                        canChange: false,
                      ),
                      Text(
                        _review!.rating!.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("(${_review!.ratingCount!})"),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _review!.reviews!.length,
                      itemBuilder: (itemBuilder, index) => ReviewCard(
                        review: _review!.reviews![index],
                      ),
                    ),
                  ),
                ],
              ),
          );
    }
  }
}
