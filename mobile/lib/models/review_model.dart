class ReviewModel {
  int? id;
  double? rating;
  String? comment;
  bool? isAnonymous;
  String? createdAt;

  ReviewModel(
      {this.id, this.rating, this.comment, this.isAnonymous, this.createdAt});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = double.parse(json['rating'].toString());
    comment = json['comment'];
    isAnonymous = json['isAnonymous'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rating'] = rating;
    data['comment'] = comment;
    data['isAnonymous'] = isAnonymous;
    data['createdAt'] = createdAt;
    return data;
  }
}


class CreateReviewModel {
  double? rating;
  String? comment;
  bool? isAnonymous;

  CreateReviewModel({this.rating, this.comment, this.isAnonymous});

  CreateReviewModel.fromJson(Map<String, dynamic> json) {
    rating = double.parse(json['rating'].toString());
    comment = json['comment'];
    isAnonymous = json['isAnonymous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['comment'] = comment;
    data['isAnonymous'] = isAnonymous;
    return data;
  }
}


class ReviewDetailsModel {
  double? rating;
  int? ratingCount;
  List<ReviewCardModel>? reviews;

  ReviewDetailsModel({this.rating, this.ratingCount, this.reviews});

  ReviewDetailsModel.fromJson(Map<String, dynamic> json) {
    rating = double.parse(json['rating'].toString());
    ratingCount = json['ratingCount'];
    if (json['reviews'] != null) {
      reviews = <ReviewCardModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(ReviewCardModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewCardModel {
  int? id;
  String? username;
  double? rating;
  String? comment;
  String? createdAt;

  ReviewCardModel({this.id, this.username, this.rating, this.comment, this.createdAt});

  ReviewCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    rating = double.parse(json['rating'].toString());
    comment = json['comment'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['rating'] = rating;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    return data;
  }
}
