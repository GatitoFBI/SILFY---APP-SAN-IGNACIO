// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../views/tour_guide_view.dart';

class NameIconTopWidget extends StatelessWidget {
  final String title;

  const NameIconTopWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 📝 Título
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // 👑 Botón corona con ripple
          Material(
            color: const Color(0xffEDB440),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const TourGuideScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const beginOffset = Offset(0.0, 1.0);
                      const endOffset = Offset.zero;
                      const curve = Curves.easeOut;

                      final tween = Tween(begin: beginOffset, end: endOffset).chain(CurveTween(curve: curve));
                      final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: FadeTransition(
                          opacity: animation.drive(fadeTween),
                          child: child,
                        ),
                      );
                    },
                  ),
                );
              },
              child: SizedBox(
                width: 50,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    "assets/icons/button_icons/corona.svg",
                    color: Colors.black,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
