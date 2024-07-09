import 'dart:convert';

import 'package:flutter/foundation.dart';

class ShopReview {
  final AverageRatingPercentage averageRatingPercentage;
  final List<Review> reviews;
  ShopReview({
    required this.averageRatingPercentage,
    required this.reviews,
  });

  ShopReview copyWith({
    AverageRatingPercentage? averageRatingPercentage,
    List<Review>? reviews,
  }) {
    return ShopReview(
      averageRatingPercentage:
          averageRatingPercentage ?? this.averageRatingPercentage,
      reviews: reviews ?? this.reviews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'average_rating_percentage': averageRatingPercentage.toMap(),
      'reviews': reviews.map((x) => x.toMap()).toList(),
    };
  }

  factory ShopReview.fromMap(Map<String, dynamic> map) {
    return ShopReview(
      averageRatingPercentage: AverageRatingPercentage.fromMap(
          map['average_rating_percentage'] as Map<String, dynamic>),
      reviews: List<Review>.from(
        (map['reviews'] as List<dynamic>).map<Review>(
          (x) => Review.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopReview.fromJson(String source) =>
      ShopReview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ShopReview(average_rating_percentage: $averageRatingPercentage, reviews: $reviews)';

  @override
  bool operator ==(covariant ShopReview other) {
    if (identical(this, other)) return true;

    return other.averageRatingPercentage == averageRatingPercentage &&
        listEquals(other.reviews, reviews);
  }

  @override
  int get hashCode => averageRatingPercentage.hashCode ^ reviews.hashCode;
}

class AverageRatingPercentage {
  final double rating;
  final int totalReview;
  final Percentages percentages;
  AverageRatingPercentage({
    required this.rating,
    required this.totalReview,
    required this.percentages,
  });

  AverageRatingPercentage copyWith({
    double? rating,
    int? totalReview,
    Percentages? percentages,
  }) {
    return AverageRatingPercentage(
      rating: rating ?? this.rating,
      totalReview: totalReview ?? this.totalReview,
      percentages: percentages ?? this.percentages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'total_review': totalReview,
      'percentages': percentages.toMap(),
    };
  }

  factory AverageRatingPercentage.fromMap(Map<String, dynamic> map) {
    return AverageRatingPercentage(
      rating: map['rating'].toDouble() as double,
      totalReview: map['total_review'].toInt() as int,
      percentages:
          Percentages.fromMap(map['percentages'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AverageRatingPercentage.fromJson(String source) =>
      AverageRatingPercentage.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AverageRatingPercentage(rating: $rating, total_review: $totalReview, percentages: $percentages)';

  @override
  bool operator ==(covariant AverageRatingPercentage other) {
    if (identical(this, other)) return true;

    return other.rating == rating &&
        other.totalReview == totalReview &&
        other.percentages == percentages;
  }

  @override
  int get hashCode =>
      rating.hashCode ^ totalReview.hashCode ^ percentages.hashCode;
}

class Percentages {
  final double n1;
  final double n2;
  final double n3;
  final double n4;
  final double n5;
  Percentages({
    required this.n1,
    required this.n2,
    required this.n3,
    required this.n4,
    required this.n5,
  });

  Percentages copyWith({
    double? n1,
    double? n2,
    double? n3,
    double? n4,
    double? n5,
  }) {
    return Percentages(
      n1: n1 ?? this.n1,
      n2: n2 ?? this.n2,
      n3: n3 ?? this.n3,
      n4: n4 ?? this.n4,
      n5: n5 ?? this.n5,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '1': n1,
      '2': n2,
      '3': n3,
      '4': n4,
      '5': n5,
    };
  }

  factory Percentages.fromMap(Map<String, dynamic> map) {
    return Percentages(
      n1: map['1'] as double,
      n2: map['2'] as double,
      n3: map['3'] as double,
      n4: map['4'] as double,
      n5: map['5'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Percentages.fromJson(String source) =>
      Percentages.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Percentages(n1: $n1, n2: $n2, n3: $n3, n4: $n4, n5: $n5)';
  }

  @override
  bool operator ==(covariant Percentages other) {
    if (identical(this, other)) return true;

    return other.n1 == n1 &&
        other.n2 == n2 &&
        other.n3 == n3 &&
        other.n4 == n4 &&
        other.n5 == n5;
  }

  @override
  int get hashCode {
    return n1.hashCode ^ n2.hashCode ^ n3.hashCode ^ n4.hashCode ^ n5.hashCode;
  }
}

class Review {
  final int id;
  final String customerName;
  final String customerProfile;
  final int rating;
  final String description;
  final String createdAt;
  Review({
    required this.id,
    required this.customerName,
    required this.customerProfile,
    required this.rating,
    required this.description,
    required this.createdAt,
  });

  Review copyWith({
    int? id,
    String? customerName,
    String? customerProfile,
    int? rating,
    String? description,
    String? createdAt,
  }) {
    return Review(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerProfile: customerProfile ?? this.customerProfile,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customer_name': customerName,
      'customer_profile': customerProfile,
      'rating': rating,
      'description': description,
      'created_at': createdAt,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'].toInt() as int,
      customerName: map['customer_name'] as String,
      customerProfile: map['customer_profile'] as String,
      rating: map['rating'].toInt() as int,
      description: map['description'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, customer_name: $customerName, customer_profile: $customerProfile, rating: $rating, description: $description, created_at: $createdAt)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerName == customerName &&
        other.customerProfile == customerProfile &&
        other.rating == rating &&
        other.description == description &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerName.hashCode ^
        customerProfile.hashCode ^
        rating.hashCode ^
        description.hashCode ^
        createdAt.hashCode;
  }
}
