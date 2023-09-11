import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spontracker/utils/dimension.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  SmallText(
      {super.key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 12,
      this.height = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.justify,
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: Dimensions.font12,
          height: height),
    );
  }
}