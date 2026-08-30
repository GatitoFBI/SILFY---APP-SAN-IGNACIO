// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../1.CONFIG/Core/constants/app_constants.dart';
import '../../../../1.CONFIG/Core/services/firebase_login.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text.dart';
import '0.Navigator_Bar_View/navigator_bar_view.dart';

class WelcomeView extends StatelessWidget {
  final String imagePath = "assets/images/welcome_image.png";
  final FirebaseAuthService _authService = FirebaseAuthService();

  WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              welcomeTextWidget(),
              const SizedBox(height: 5),
              sloganText(),
              const SizedBox(height: 20),
              // getButton(
              //   context,
              //   "Sign up with Google",
              //   "assets/icons/button_icons/google.svg",
              //   onTap: () async {
              //     final user = await _authService.signInWithGoogle();
              //     if (user != null) {
              //       context.read<UsernameCubit>().changeUsername(user.displayName ?? "Cuenta Incógnita");
              //       Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => const NavigatorBarView(),
              //         ),
              //       );
              //     }
              //   },
              // ),
              // const SizedBox(height: 20),
              getButton(
                context,
                "Ingresa a SILFY",
                "assets/icons/button_icons/hacker.svg",
                iconColor: Colors.black,
                onTap: () async {
                  final user = await _authService.signInAsGuest();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NavigatorBarView(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  Widget welcomeTextWidget() {
    return const Column(
      children: [
        AppText(
          text: "Welcome",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        AppText(
          text: "to SILFY",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "All of San Ignacio in the palm of \nyour hand",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: const Color(0xffFCFCFC).withOpacity(0.7),
    );
  }

  Widget getButton(
    BuildContext context,
    String text,
    String iconPath, {
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return AppButton(
      widthIcon: 30,
      iconColor: iconColor,
      label: text,
      fontWeight: FontWeight.w600,
      padding: const EdgeInsets.symmetric(vertical: 25),
      trailingIconPath: iconPath,
      onPressed: onTap ?? () {},
    );
  }
}
