// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../1.CONFIG/Core/constants/app_constants.dart';
import '0.Navigator_Bar_View/navigator_bar_view.dart';
import 'welcome_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    const delay = Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  Future<void> onTimerFinished() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Si ya inició sesión, directo al Home
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const NavigatorBarView(),
      ));
    } else {
      // Sino, mostrar la pantalla de bienvenida
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => WelcomeView(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: splashScreenIcon(),
        ),
      ),
    );
  }
}

Widget splashScreenIcon() {
  const String iconPath = "assets/icons/splash_screen_icon.svg";
  return SvgPicture.asset(
    iconPath,
    // ignore: deprecated_member_use
    color: Colors.white,
  );
}
