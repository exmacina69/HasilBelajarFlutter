import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:spontracker/base/custom_loader.dart';
import 'package:spontracker/pages/auth/sign_up_page.dart';
import 'package:spontracker/routes/route_helper.dart';
import 'package:spontracker/utils/dimension.dart';
import 'package:spontracker/widgets/app_text_field.dart';
import 'package:spontracker/widgets/big_text.dart';

import '../../base/show_costum_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomScankBar("Masukkan email anda", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomScankBar("Email yang anda tidak valid", title: "Email");
      } else if (password.isEmpty) {
        showCustomScankBar("Masukkan password anda", title: "Password");
      } else if (password.length < 6) {
        showCustomScankBar("Passsword tidak bisa kurang dari 6 karakter",
            title: "Password");
      } else {
        //showCustomScankBar("Anjay bener", title: "Perfect");
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomScankBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //logo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                              foregroundColor: Colors.white,
                              radius: Dimensions.height20 * 4,
                              backgroundImage: AssetImage(
                                  "assets/image/logo ga transparan.png")),
                        ),
                      ),
                      //welcome
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SPONTRACKER",
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 2.5 +
                                      Dimensions.font20 / 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "YUK TEMUKAN SPONSORMU!!!",
                                style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  color: Colors.grey[500],
                                  //fontWeight: FontWeight.bold,
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //email
                      AppTextField(
                          textController: emailController,
                          hintText: "Email",
                          icon: Icons.email),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //password
                      AppTextField(
                        textController: passwordController,
                        hintText: "Password",
                        icon: Icons.key_sharp,
                        isObscure: true,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      Row(
                        children: [
                          Expanded(child: Container()),
                          RichText(
                              text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.back(),
                                  text: "Masuk ke akun anda",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: Dimensions.font20))),
                          SizedBox(
                            width: Dimensions.width20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 3,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: Color.fromARGB(255, 248, 107, 20)),
                          child: Center(
                            child: BigText(
                              text: "Sign In",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Tidak punya akun?",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => SignUpPage(),
                                        transition: Transition.fade),
                                  text: " Buat Akun",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: Dimensions.font20))
                            ]),
                      ),
                    ],
                  ),
                )
              : CustomLoader();
        }));
  }
}
