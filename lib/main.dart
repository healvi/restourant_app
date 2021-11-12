import 'package:flutter/material.dart';
import 'package:restourant_app/common/style.dart';
import 'package:restourant_app/ui/restaourant_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: typographiRes,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue,
              textTheme: typographiRes.apply(bodyColor: Colors.black),
              titleTextStyle: typographiRes.headline6,
              elevation: 0)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestourantListPage();
  }
}
