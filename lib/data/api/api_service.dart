import 'dart:convert';

import 'package:restourant_app/data/model/restourant_data.dart';
import 'package:restourant_app/data/model/restourant_list_data.dart';
import 'package:http/http.dart' as http;
import 'package:restourant_app/data/model/restourant_search_data.dart';

class ApiService {
  static const String baseUrll = 'https://restaurant-api.dicoding.dev';
  static const String list = '/list';
  static const String detail = '/detail/';
  static const String search = '/search?q=';

  Future<RestaurantList> listRestourant() async {
    final response = await http.get(Uri.parse(baseUrll + list));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Maaf Silahkan Coba Lagi');
    }
  }

  Future<RestaurantResult> detailRestourant(id) async {
    final response =
        await http.get(Uri.parse(baseUrll + detail + id.toString()));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Maaf Silahkan Coba Lagi');
    }
  }

  Future<RestaurantSearch> searchRestourant(query) async {
    final response = await http.get(Uri.parse(baseUrll + search + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Maaf Silahkan Coba Lagi');
    }
  }
}
