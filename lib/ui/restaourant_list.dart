import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/provider/restaourant_provider.dart';
import 'package:restourant_app/ui/build_restourant_item.dart';
import 'package:restourant_app/ui/details_restaurant.dart';
import 'package:restourant_app/ui/favorite_page.dart';
import 'package:restourant_app/ui/search_restourant.dart';
import 'package:restourant_app/ui/settings_page.dart';
import 'package:restourant_app/utils/notification_helper.dart';

class RestourantListPage extends StatefulWidget {
  @override
  State<RestourantListPage> createState() => _RestourantListPageState();
}

class _RestourantListPageState extends State<RestourantListPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailsRestaurant.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaourantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.Hasdata) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Food Hunter',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return searchRestourantPage();
                      }));
                    },
                    icon: const Icon(Icons.search, color: Colors.white)),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FavoritePage();
                      }));
                    },
                    icon: const Icon(Icons.favorite, color: Colors.red)),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SettingsPage();
                      }));
                    },
                    icon: const Icon(Icons.settings, color: Colors.white))
              ],
            ),
            body: BuildRestourantItem(restaurant: state.result.restaurants));
      } else if (state.state == ResultState.Nodata) {
        return _empty(state.Message);
      } else if (state.state == ResultState.Error) {
        return _empty(state.Message);
      } else {
        return _empty("");
      }
    });
  }

  Widget _empty(String message) {
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
                icon: const Icon(Icons.search, color: Colors.white)),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FavoritePage();
                  }));
                },
                icon: const Icon(Icons.favorite, color: Colors.red)),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingsPage();
                  }));
                },
                icon: const Icon(Icons.settings, color: Colors.white))
          ],
        ),
        body: Center(child: Text(message)));
  }
}
