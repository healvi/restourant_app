import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/db/database_provider.dart';
import 'package:restourant_app/data/model/restourant_add.dart';
import 'package:restourant_app/provider/restaourant_provider_detail.dart';
import 'package:restourant_app/widgets/platform_widget.dart';

class DetailsRestaurant extends StatefulWidget {
  static const routeName = '/article_detail';
  final String restourantId;
  DetailsRestaurant({required this.restourantId});

  @override
  State<DetailsRestaurant> createState() =>
      _DetailsRestaurantState(restourantId: restourantId);
}

class _DetailsRestaurantState extends State<DetailsRestaurant> {
  final String restourantId;
  _DetailsRestaurantState({required this.restourantId});

  late RestaourantProviderDetails stateProvider;
  late RestaurantAdd restourant;
  @override
  void initState() {
    super.initState();
    stateProvider =
        RestaourantProviderDetails(apiService: ApiService(), id: restourantId);
    stateProvider.id = restourantId;
  }

  Widget _buildDetail(BuildContext context) {
    return Consumer<RestaourantProviderDetails>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.Hasdata) {
        restourant = state.result.restaurant;
        return _detailRestourant(context, state.result.restaurant);
      } else if (state.state == ResultState.Nodata) {
        return Center(child: Text(state.Message));
      } else if (state.state == ResultState.Error) {
        return Center(child: Text(state.Message));
      } else {
        return const Center(child: Text(''));
      }
    });
  }

  Widget _detailRestourant(BuildContext context, RestaurantAdd restaurant) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(restourantId),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.network(
                          "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                isFavorite
                                    ? IconButton(
                                        icon: Icon(Icons.favorite),
                                        color: Theme.of(context).accentColor,
                                        onPressed: () => provider
                                            .removeFavorite(restourantId),
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.favorite_border),
                                        color: Theme.of(context).accentColor,
                                        onPressed: () =>
                                            provider.addFavorite(restaurant),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: Colors.grey),
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          Divider(color: Colors.grey),
                          Text('City : ${restaurant.city}'),
                          SizedBox(height: 10),
                          Text('Rating : ${restaurant.rating} '),
                          Divider(color: Colors.grey),
                          Text(
                            restaurant.description,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<RestaourantProviderDetails>(
            create: (_) => RestaourantProviderDetails(
                  apiService: ApiService(),
                  id: restourantId,
                ),
            child: _buildDetail(context)));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        child: ChangeNotifierProvider<RestaourantProviderDetails>(
            create: (_) => RestaourantProviderDetails(
                  apiService: ApiService(),
                  id: restourantId,
                ),
            child: _buildDetail(context)));
  }
}
