import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/data/model/restourant_add.dart';
import 'package:restourant_app/data/model/restourant_list_data.dart';
import 'package:restourant_app/ui/details_restaurant.dart';
import 'package:restourant_app/widgets/rating_display.dart';

class BuildRestourantItem extends StatelessWidget {
  final List<RestaurantAdd>? restaurant;

  const BuildRestourantItem({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: const Text(
                  "HIGHLIGHT",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    CarouselSlider.builder(
                      options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          enableInfiniteScroll: true),
                      itemCount: restaurant!.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        final RestaurantAdd restauranting = restaurant![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailsRestaurant(
                                restourantId: restauranting.id,
                              );
                            }));
                          },
                          child: Container(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "https://restaurant-api.dicoding.dev/images/small/${restauranting.pictureId}",
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          )),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: const Text(
                  "Restaurant List",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    padding: EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      final RestaurantAdd restauranting = restaurant![index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailsRestaurant(
                              restourantId: restauranting.id,
                            );
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image.network(
                                      "https://restaurant-api.dicoding.dev/images/small/${restauranting.pictureId}",
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Container(
                                    child: Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  restauranting.name,
                                                  style:
                                                      TextStyle(fontSize: 14.0),
                                                ),
                                              ),
                                              Container(
                                                child: ratingDisplay(
                                                    value: restauranting.rating
                                                        .toInt()),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.blue[200],
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          restauranting.name,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 9.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: restaurant!.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
