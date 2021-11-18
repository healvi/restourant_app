import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/model/restourant_data.dart';
import 'package:restourant_app/provider/restaourant_provider_detail.dart';
import 'package:restourant_app/widgets/platform_widget.dart';

class DetailsRestaurant extends StatefulWidget {
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

  Widget _detailRestourant(BuildContext context, Restaurant restaurant) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey),
                  Text(
                    restaurant.name,
                    style: TextStyle(
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
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("restourant"),
        ),
        body: _buildDetail(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Food Hunter'),
          transitionBetweenRoutes: false,
        ),
        child: _buildDetail(context));
  }
}
