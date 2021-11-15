import 'package:flutter/cupertino.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/model/restourant_list_data.dart';

enum ResultState { loading, Nodata, Hasdata, Error }

class RestaourantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaourantProvider({required this.apiService}) {
    _fetchAllRestourant();
  }

  late RestaurantList _RestourantResult;
  late ResultState _state;
  String _message = '';

  String get Message => _message;
  RestaurantList get result => _RestourantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestourant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restourant = await apiService.listRestourant();
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
      return _message = 'Maaf Mungkin Internet anda salah';
    }
  }
}
