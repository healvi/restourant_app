import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/model/restourant_add.dart';
import 'package:restourant_app/data/model/restourant_list_data.dart';
import 'package:restourant_app/ui/build_restourant_item.dart';
import 'package:restourant_app/ui/search_restourant.dart';
import 'package:restourant_app/widgets/platform_widget.dart';

class RestourantListPage extends StatefulWidget {
  @override
  State<RestourantListPage> createState() => _RestourantListPageState();
}

class _RestourantListPageState extends State<RestourantListPage> {
  late Future<RestaurantList> _restourant;

  @override
  void initState() {
    super.initState();
    _restourant = ApiService().listRestourant();
  }

  Widget _buildRestourant(BuildContext context) {
    return FutureBuilder(
        future: _restourant,
        builder: (context, AsyncSnapshot<RestaurantList> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              final List<RestaurantAdd>? restaurant =
                  snapshot.data?.restaurants;
              return BuildRestourantItem(restaurant: restaurant);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.data!.message));
            } else {
              return Text(' ');
            }
          }
        });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Food Hunter',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return searchRestourantPage();
                  }));
                },
                icon: Icon(Icons.search, color: Colors.white))
          ],
        ),
        body: _buildRestourant(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Food Hunter'),
        transitionBetweenRoutes: false,
      ),
      child: _buildRestourant(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
