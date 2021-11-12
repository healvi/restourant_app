import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String picturedId;
  late String city;
  late double rating;
  late MenusModel menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.picturedId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    picturedId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'].toDouble();
    menus = MenusModel.fromJson(restaurant['menus']);
  }
}

class MenusModel {
  final List<FoodsModel> foods;
  final List<DrinksModel> drinks;

  MenusModel({required this.foods, required this.drinks});

  List<Object> get props => [foods, drinks];

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
        foods: List<FoodsModel>.from(
          json['foods'].map(
            (food) => FoodsModel.fromJson(
              food,
            ),
          ),
        ),
        drinks: List<DrinksModel>.from(
          json['drinks'].map(
            (drink) => DrinksModel.fromJson(
              drink,
            ),
          ),
        ),
      );
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((e) => Restaurant.fromJson(e)).toList();;
}

class DrinksModel {
  final String name;

  DrinksModel({
    required this.name,
  });

  List<Object> get props => [
        name,
      ];

  factory DrinksModel.fromJson(Map<String, dynamic> json) => DrinksModel(
        name: json['name'],
      );
}

class FoodsModel {
  final String name;

  FoodsModel({
    required this.name,
  });

  List<Object> get props => [
        name,
      ];

  factory FoodsModel.fromJson(Map<String, dynamic> json) => FoodsModel(
        name: json['name'],
      );
}
