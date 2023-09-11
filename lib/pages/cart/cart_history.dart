import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:spontracker/base/no_data_page.dart';
import 'package:spontracker/controllers/cart_controller.dart';
import 'package:spontracker/pages/cart/status.dart';
import 'package:spontracker/utils/app_constants.dart';
import 'package:spontracker/utils/dimension.dart';
import 'package:spontracker/widgets/app_icon.dart';
import 'package:spontracker/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:spontracker/widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
      );
    }

    return Scaffold(
      body: Column(children: [
        Container(
          height: Dimensions.height10 * 10,
          color: Color.fromARGB(255, 248, 107, 20),
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimensions.height45),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            BigText(
              text: "Riwayat Pengajuan",
              size: Dimensions.font26,
              color: Colors.white,
            ),
            AppIcon(
              icon: Icons.menu_open_outlined,
              iconColor: Color.fromARGB(255, 248, 107, 20),
              backgroundColor: Colors.white,
            )
          ]),
        ),
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getCartHistoryList().length > 0
              ? Expanded(
                  child: Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for (int i = 0; i < itemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height10 * 12,
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                          itemsPerOrder[i],
                                          (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    height:
                                                        Dimensions.height10 * 8,
                                                    width:
                                                        Dimensions.width10 * 8,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                2),
                                                        image: DecorationImage(
                                                            image: NetworkImage(AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!))),
                                                  )
                                                : Container();
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: Dimensions.height10 * 8,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SmallText(
                                                text: "Status",
                                                color: Colors.black,
                                              ),
                                              BigText(
                                                text: itemsPerOrder[i]
                                                        .toString() +
                                                    " Pengajuan",
                                                color: Colors.black,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderStatusPage()),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimensions.width10,
                                                      vertical:
                                                          Dimensions.height10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              255,
                                                              248,
                                                              107,
                                                              20))),
                                                  child: SmallText(
                                                    text: "Diproses",
                                                    color: Color.fromARGB(
                                                        255, 248, 107, 20),
                                                  ),
                                                ),
                                              )
                                            ]),
                                      )
                                    ],
                                  )
                                ]),
                          )
                      ],
                    ),
                  ),
                ))
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: const Center(
                      child: NoDataPage(
                    text: "Anda Belum Mengajukan Permohonan",
                    imgPath: "assets/image/empty_box.png",
                  )),
                );
        }),
      ]),
    );
  }
}
