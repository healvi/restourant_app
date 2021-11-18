import 'package:flutter/cupertino.dart';
import 'package:restourant_app/data/db/database_helper.dart';
import 'package:restourant_app/data/model/restourant_add.dart';
import 'package:restourant_app/provider/restaourant_provider.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantAdd> _Favorites = [];
  List<RestaurantAdd> get Favorites => _Favorites;

  void _getFavorites() async {
    _Favorites = await databaseHelper.getFavorites();
    if (_Favorites.length > 0) {
      _state = ResultState.Hasdata;
    } else {
      _state = ResultState.Nodata;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantAdd article) async {
    try {
      await databaseHelper.insertFavorite(article);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final FavoriteedArticle = await databaseHelper.getFavoritesByName(id);
    return FavoriteedArticle.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
