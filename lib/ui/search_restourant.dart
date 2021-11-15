import 'package:flutter/cupertino.dart';
import 'package:restourant_app/data/api/api_service.dart';
import 'package:restourant_app/data/model/restourant_add.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/data/model/restourant_search_data.dart';
import 'package:restourant_app/ui/build_restourant_item.dart';
import 'package:restourant_app/widgets/platform_widget.dart';

class searchRestourantPage extends StatefulWidget {
  @override
  State<searchRestourantPage> createState() => _searchRestourantPageState();
}

class _searchRestourantPageState extends State<searchRestourantPage> {
  late Future _restourant;
  bool _isSearch = false;
  String searchText = "";
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();
  Icon Customicon = Icon(Icons.search, color: Colors.white);
  Widget title = const Text(
    'Search Food',
    style: TextStyle(fontSize: 16),
  );
  var searchhasil = Center(child: CircularProgressIndicator());

  _searchState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _isSearch = false;
          searchText = "";
        });
      } else {
        _isSearch = true;
        searchText = _searchController.text;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _restourant = ApiService().listRestourant();
    _isSearch = false;
  }

  Widget _buildRestourant(BuildContext context) {
    return FutureBuilder(
        future: _restourant,
        builder: (context, AsyncSnapshot snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return searchhasil;
          } else {
            if (snapshot.hasData) {
              final List<RestaurantAdd>? restaurant =
                  snapshot.data?.restaurants;
              return BuildRestourantItem(restaurant: restaurant);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.data!.error.toString()));
            } else {
              return const Text(' ');
            }
          }
        });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: buildAppBar(context),
      ),
      body: _buildRestourant(context),
      key: globalKey,
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSearchTextField(
          onSubmitted: (value) {
            searchApi(value);
          },
          controller: _searchController,
        ),
        transitionBetweenRoutes: false,
      ),
      child: _buildRestourant(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: title,
      actions: <Widget>[
        IconButton(
          icon: Customicon,
          onPressed: () {
            if (Customicon.icon == Icons.search) {
              Customicon = Icon(Icons.close, color: Colors.white);
              title = TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: "Find........",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onSubmitted: searchApi,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd(Customicon, title);
            }
          },
        )
      ],
    );
  }

  void searchApi(String searchText) {
    if (_isSearch != null) {
      setState(() {
        _restourant = ApiService().searchRestourant(searchText.toLowerCase());
      });
    }
  }

  void _handleSearchStart() {
    setState(() {
      _isSearch = true;
    });
  }

  void _handleSearchEnd(icon, title) {
    setState(() {
      this.Customicon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.title = new Text(
        "Search",
        style: new TextStyle(color: Colors.white),
      );
      _isSearch = false;
      _searchController.clear();
    });
  }
}
