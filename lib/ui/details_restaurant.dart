import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/data/model/restourant_data.dart';

class DetailsRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  DetailsRestaurant({required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Hero(
                  tag: restaurant.picturedId,
                  child: Image.network(restaurant.picturedId)),
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
              Text(
                "Makanan",
                style: TextStyle(fontSize: 16),
              ),
              Container(
                height: 200,
                padding: EdgeInsets.all(16),
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: restaurant.menus.foods.map((e) {
                      return Text(
                        e.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0),
                      );
                    }).toList()),
              ),
              Text(
                "Minuman",
                style: TextStyle(fontSize: 16),
              ),
              Container(
                height: 200,
                padding: EdgeInsets.all(16),
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: restaurant.menus.drinks.map((e) {
                      return Text(
                        e.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0),
                      );
                    }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
