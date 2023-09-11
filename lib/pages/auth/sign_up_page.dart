import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:spontracker/base/show_costum_snackbar.dart';
import 'package:spontracker/controllers/auth_controller.dart';
import 'package:spontracker/models/signup_body_model.dart';
import 'package:spontracker/routes/route_helper.dart';
import 'package:spontracker/utils/dimension.dart';
import 'package:spontracker/widgets/app_text_field.dart';
import 'package:spontracker/widgets/big_text.dart';

import '../../base/custom_loader.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["t.png", "f.png", "g.png"];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomScankBar("Masukkan nama anda", title: "Nama");
      } else if (phone.isEmpty) {
        showCustomScankBar("Masukkan nomor telepon anda",
            title: "Nomor Telepon");
      } else if (email.isEmpty) {
        showCustomScankBar("Masukkan email anda", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomScankBar("Email yang anda masukkan tidak valid", title: "Email");
      } else if (password.isEmpty) {
        showCustomScankBar("Masukkan password anda", title: "Password");
      } else if (password.length < 6) {
        showCustomScankBar("Passsword tidak bisa kurang dari 6 karakter",
            title: "Password");
      } else {
        //showCustomScankBar("Anjay bener", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Registrasi Berhasil");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomScankBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
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
                      //nama
                      AppTextField(
                          textController: nameController,
                          hintText: "Nama",
                          icon: Icons.person),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //nomor telepon
                      AppTextField(
                          textController: phoneController,
                          hintText: "Nomor Telepon",
                          icon: Icons.phone),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
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
                              text: "Sign Up",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Sudah punya akun?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20))),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Sign Up menggunakan metode berikut",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16))),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundImage: AssetImage(
                                        "assets/image/" + signUpImages[index]),
                                  ),
                                )),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
