import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/component/button_component.dart';
import '../../../core/component/form_component.dart';
import '../../../core/component/loading_component.dart';
import '../../../core/component/radio_component.dart';
import '../../../core/component/spacer_component.dart';
import '../../../core/component/text_component.dart';
import '../../../core/theme/color_theme.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/img.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<LoginController>();

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(30),
            children: [
              Image.asset(Img.loginBanner),
              const TextTitle(text: 'LOGIN'),
              spacer(25),
              FormComponent(
                textStyle: GoogleFonts.outfit(fontSize: 16),
                controller: state.emails,
                type: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  MyIcon.email,
                  color: ColorApp.secondary,
                  size: 18,
                ),
                hint: 'Email',
              ),
              spacer(10),
              Obx(
                () => FormComponent(
                  textStyle: GoogleFonts.outfit(fontSize: 16),
                  controller: state.passwords,
                  type: TextInputType.visiblePassword,
                  obsecure: state.obsecureText.value,
                  prefixIcon: const Icon(
                    MyIcon.password,
                    color: ColorApp.secondary,
                    size: 18,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        state.obsecureText.value = !state.obsecureText.value,
                    icon: state.obsecureText.isTrue
                        ? const Icon(
                            MyIcon.visibilityOff,
                            color: ColorApp.secondary,
                            size: 18,
                          )
                        : const Icon(
                            MyIcon.visibility,
                            color: ColorApp.secondary,
                            size: 18,
                          ),
                  ),
                  hint: 'Password',
                ),
              ),
              spacer(10),
              ButtonComponent(
                text: 'LOGIN',
                ontap: () => state.login(
                  state.emails.text,
                  state.passwords.text,
                ),
              ),
              spacer(10),
              Obx(
                () => RadioComponent(
                    title: 'ingat status login?',
                    value: state.saveLoginStatus.value,
                    onchange: (value) {
                      state.saveLoginStatus.value = value;
                    }),
              ),
            ],
          ),
          LoadingComponent(isLoading: state.isLoading)
        ],
      ),
    );
  }
}
