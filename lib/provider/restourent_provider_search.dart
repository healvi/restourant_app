import 'package:flutter/cupertino.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/model/restourant_search_data.dart';

enum ResultState { loading, Nodata, Hasdata, Error }

class SearchProvider extends ChangeNotifier {
  late final ApiService apiService;
  late final String query;

  SearchProvider({required this.apiService, required this.query}) {
    searchAllRestourant(query);
  }

  late RestaurantSearch _RestourantResult;
  late ResultState _state;
  String _message = '';

  String get Message => _message;
  RestaurantSearch get result => _RestourantResult;
  ResultState get state => _state;

  Future<dynamic> searchAllRestourant(query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restourant = await apiService.searchRestourant(query);
      if (restourant.restaurants.isEmpty) {
        _state = ResultState.Nodata;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.Hasdata;
        notifyListeners();
        return _RestourantResult = restourant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Maaf Silahkan Coba Lagi";
    }
  }
}
