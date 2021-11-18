import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/provider/restaourant_provider.dart';
import 'package:restourant_app/ui/build_restourant_item.dart';
import 'package:restourant_app/ui/search_restourant.dart';
import 'package:restourant_app/ui/settings_page.dart';
import 'package:restourant_app/widgets/platform_widget.dart';

class RestourantListPage extends StatefulWidget {
  @override
  State<RestourantListPage> createState() => _RestourantListPageState();
}

class _RestourantListPageState extends State<RestourantListPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildRestourant(BuildContext context) {
    return Consumer<RestaourantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.Hasdata) {
        return BuildRestourantItem(restaurant: state.result.restaurants);
      } else if (state.state == ResultState.Nodata) {
        return Center(child: Text(state.Message));
      } else if (state.state == ResultState.Error) {
        return Center(child: Text(state.Message));
      } else {
        return const Center(child: Text(''));
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
                icon: const Icon(Icons.search, color: Colors.white)),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingsPage();
                  }));
                },
                icon: const Icon(Icons.settings, color: Colors.white))
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
        child: _buildRestourant(context));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
