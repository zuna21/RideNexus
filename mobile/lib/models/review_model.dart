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
