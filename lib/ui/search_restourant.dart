import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/provider/restourent_provider_search.dart';
import 'package:restourant_app/ui/build_restourant_item.dart';
import 'package:restourant_app/widgets/platform_widget.dart';

class searchRestourantPage extends StatefulWidget {
  @override
  State<searchRestourantPage> createState() => _searchRestourantPageState();
}

class _searchRestourantPageState extends State<searchRestourantPage> {
  bool _isSearch = false;
  String searchText = "";

  TextEditingController _searchController = TextEditingController();
  Icon Customicon = Icon(Icons.search, color: Colors.white);
  Widget title = const Text(
    'Search Food',
    style: TextStyle(fontSize: 16),
  );
  late SearchProvider stateProvider;

  @override
  void initState() {
    super.initState();
    _isSearch = false;
  }

  Widget _buildRestourant(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, state, _) {
      stateProvider = state;
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.Hasdata) {
        return BuildRestourantItem(restaurant: state.result.restaurants);
      } else if (state.state == ResultState.Nodata) {
        return Center(child: Text(state.Message));
      } else if (state.state == ResultState.Error) {
        return Center(child: Text(state.Message));
      } else {
        return const Center(child: Text('gagal memuat data'));
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: buildAppBar(context),
        ),
        body: ChangeNotifierProvider<SearchProvider>(
            create: (_) => provider, child: _buildRestourant(context)));
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
        child: ChangeNotifierProvider<SearchProvider>(
            create: (_) => provider, child: _buildRestourant(context)));
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
      stateProvider.searchAllRestourant(searchText);
    }
  }

  void _handleSearchStart() {
    setState(() {
      _isSearch = true;
    });
  }

  void _handleSearchEnd(icon, title) {
    setState(() {
      Customicon = const Icon(
        Icons.search,
        color: Colors.white,
      );
      this.title = const Text(
        "Search",
        style: TextStyle(color: Colors.white),
      );
      _isSearch = false;
      _searchController.clear();
    });
  }
}
