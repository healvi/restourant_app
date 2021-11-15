import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/model/restourant_data.dart';
import 'package:restourant_app/widgets/platform_widget.dart';

class DetailsRestaurant extends StatefulWidget {
  final String restourantId;
  DetailsRestaurant({required this.restourantId});

  @override
  State<DetailsRestaurant> createState() =>
      _DetailsRestaurantState(restourantId: restourantId);
}

class _DetailsRestaurantState extends State<DetailsRestaurant> {
  late Future<RestaurantResult> _restourantDetail;
  final String restourantId;
  _DetailsRestaurantState({required this.restourantId});
  @override
  void initState() {
    super.initState();
    _restourantDetail = ApiService().detailRestourant(restourantId);
  }

  Widget _buildDetail(BuildContext context) {
    return FutureBuilder(
        future: _restourantDetail,
        builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              final Restaurant? restaurant = snapshot.data?.restaurant;
              return _detailRestourant(context, restaurant!);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.data!.message));
            } else {
              return Text(' ');
            }
          }
        });
  }

  Widget _detailRestourant(BuildContext context, Restaurant restaurant) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return _buildDetail(context);
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Food Hunter'),
        transitionBetweenRoutes: false,
      ),
      child: _buildDetail(context),
    );
  }
}
