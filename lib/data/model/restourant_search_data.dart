// To parse this JSON data, do
//
//     final restaurantList = restaurantListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:restourant_app/data/model/restourant_add.dart';

class RestaurantSearch {
  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantAdd> restaurants;

  factory RestaurantSearch.fromRawJson(String str) =>
      RestaurantSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantAdd>.from(
            json["restaurants"].map((x) => RestaurantAdd.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
