import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ratingDisplay extends StatelessWidget {
  final int value;
  const ratingDisplay({Key? key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          size: 20,
          color: Colors.amber,
        );
      }),
    );
  }
}
