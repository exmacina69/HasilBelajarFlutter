import 'package:get/get.dart';
import 'package:spontracker/pages/auth/sign_in_page.dart';
import 'package:spontracker/pages/cart/cart_page.dart';
import 'package:spontracker/pages/home/main_sponsor_page.dart';
import 'package:spontracker/pages/splash/splash_page.dart';
import 'package:spontracker/pages/sponsor/popular_sponsor_detail.dart';
import 'package:spontracker/pages/sponsor/recommended_sponsor_detail.dart';

import '../pages/home/home_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularSponsor = "/popular-sponsor";
  static const String recommendedSponsor = "/recommended-sponsor";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularSponsor(int pageId, String page) =>
      '$popularSponsor?pageId=$pageId&page=$page';
  static String getRecommendedSponsor(int pageId, String page) =>
      '$recommendedSponsor?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: signIn, page: () => SignInPage(), transition: Transition.fade),
    GetPage(
        name: popularSponsor,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularSponsorDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedSponsor,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedSponsorDetail(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
