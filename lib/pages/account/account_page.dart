import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:spontracker/base/custom_loader.dart';
import 'package:spontracker/base/show_costum_snackbar.dart';
import 'package:spontracker/controllers/auth_controller.dart';
import 'package:spontracker/controllers/cart_controller.dart';
import 'package:spontracker/controllers/user_controller.dart';
import 'package:spontracker/routes/route_helper.dart';
import 'package:spontracker/utils/dimension.dart';
import 'package:spontracker/widgets/account_widget.dart';
import 'package:spontracker/widgets/app_icon.dart';
import 'package:spontracker/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 107, 20),
        centerTitle: true,
        title: BigText(
          text: "Profil",
          size: Dimensions.font26,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(children: [
                      //profile icom
                      Container(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          child: Image.asset(
                            "assets/image/foto1.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //nama
                            AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  backgroundColor:
                                      Color.fromARGB(255, 248, 107, 20),
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(
                                    text: userController.userModel.name)),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //no telp
                            AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  backgroundColor: Colors.yellow,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(
                                    text: userController.userModel.phone)),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //email
                            AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.email,
                                  backgroundColor: Colors.yellow,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(
                                    text: userController.userModel.email)),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //alamat
                            AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.location_on,
                                  backgroundColor: Colors.yellow,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(
                                    text:
                                        "Jl.Kutilang 1 no.101 Rt 03/11, Depok J...")),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //pesan
                            AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.message,
                                  backgroundColor: Colors.redAccent,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(
                                    text: "Anda Belum Mempunyai Pesan")),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //pesan
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>().userLoggedIn()) {
                                  Get.find<AuthController>().clearSharedData();
                                  Get.find<CartController>().clear();
                                  Get.find<CartController>().clearCartHistory();
                                  Get.offNamed(RouteHelper.getSignInPage());
                                } else {
                                  print("You Logged Out");
                                  showCustomScankBar("Sudah Logout Puh");
                                }
                              },
                              child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: "Log Out")),
                            )
                          ],
                        ),
                      ))
                    ]),
                  )
                : CustomLoader())
            : Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 12,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          image: DecorationImage(
                              //fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/image/signintocontinue.png"))),
                    ),
                    SizedBox(
                      height: Dimensions.height45,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.height20 * 4,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 248, 107, 20),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: Center(
                            child: BigText(
                          text: "Sign in",
                          color: Colors.white,
                          size: Dimensions.font26,
                        )),
                      ),
                    )
                  ],
                )),
              );
      }),
    );
  }
}
