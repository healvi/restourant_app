import 'package:flutter/cupertino.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/model/restourant_data.dart';
import 'package:restourant_app/data/model/restourant_list_data.dart';

enum ResultState { loading, Nodata, Hasdata, Error }

class RestaourantProviderDetails extends ChangeNotifier {
  final ApiService apiService;
  String id;
  RestaourantProviderDetails({required this.apiService, required this.id}) {
    _fetchDetailRestourant();
  }

  late RestaurantResult _RestourantResult;
  late ResultState _state;
  String _message = '';

  String get Message => _message;
  RestaurantResult get result => _RestourantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestourant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restourant = await apiService.detailRestourant(id);
      if (restourant.restaurant == null || restourant.restaurant == []) {
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
