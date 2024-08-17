import 'package:flutter/material.dart';
import 'package:mobile/models/review_model.dart';
import 'package:mobile/services/review_service.dart';
import 'package:mobile/widgets/rating.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.id});

  final int id;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool _isAnonymous = true;
  final _comment = TextEditingController();
  double _rating = 0;
  final _createReview = CreateReviewModel();
  final reviewService = ReviewService();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void onChange(double value) {
    _rating = value;
  }

  Future<void> onSubmit() async {
    _createReview.isAnonymous = _isAnonymous;
    _createReview.rating = _rating;
    _createReview.comment = _comment.text;

    try {
      await reviewService.create(_createReview, widget.id);
    } catch(e) {
      print(e);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

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
                              value: true, groupValue: _isAnonymous, onChanged: (value) {
                                setState(() {
                                  _isAnonymous = value!;
                                });
                              }),
                          const Spacer(),
                          const Text("Javno"),
                          Radio(
                              value: false,
                              groupValue: _isAnonymous,
                              onChanged: (value) {
                                setState(() {
                                  _isAnonymous = value!;
                                });
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text("Povuci za ocjenu"),
                    Rating(
                      rating: 0,
                      onChange: (p0) => onChange(p0),
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextField(
                      controller: _comment,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '(Nije obavezno) Ostavite komentar...',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onSubmit,
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
