import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/data/db/database_provider.dart';
import 'package:restourant_app/ui/build_restourant_item.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(),
          body: BuildRestourantItem(restaurant: provider.Favorites),
        );
      },
    );
  }
}
