import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spontracker/utils/dimension.dart';
import 'package:spontracker/widgets/big_text.dart';
import 'package:spontracker/widgets/icon_and_text_widget.dart';
import 'package:spontracker/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 248, 107, 20),
                  size: Dimensions.height15,
                );
              }),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "Jakarta , Indonesia"),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.attach_money_rounded,
                text: "Rp.4.500.000",
                iconColor: Colors.green),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: "1 Hari",
                iconColor: Colors.black)
          ],
        )
      ],
    );
  }
}
