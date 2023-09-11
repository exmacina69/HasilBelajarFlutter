import 'package:flutter/material.dart';
import 'package:spontracker/controllers/cart_controller.dart';
import 'package:spontracker/controllers/popular_sponsor_controller.dart';
import 'package:spontracker/pages/auth/sign_in_page.dart';
import 'package:spontracker/pages/auth/sign_up_page.dart';
import 'package:spontracker/pages/cart/cart_page.dart';
import 'package:spontracker/pages/home/main_sponsor_page.dart';
import 'package:get/get.dart';
import 'package:spontracker/pages/home/sponsor_page_body.dart';
import 'package:spontracker/pages/splash/splash_page.dart';
import 'package:spontracker/pages/sponsor/popular_sponsor_detail.dart';
import 'package:spontracker/pages/sponsor/recommended_sponsor_detail.dart';
import 'controllers/recommended_sponsor_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'routes/route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    //Get.find<PopularProductController>().getPopularProductList();
    //Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //home: SignInPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
