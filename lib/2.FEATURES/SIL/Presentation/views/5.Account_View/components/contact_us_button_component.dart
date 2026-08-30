import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../1.CONFIG/Core/constants/app_constants.dart';

class ContactUsButton extends StatefulWidget {
  final String linkmessage;

  const ContactUsButton({super.key, required this.linkmessage});

  @override
  State<ContactUsButton> createState() => _ContactUsButtonState();
}

class _ContactUsButtonState extends State<ContactUsButton> {
  bool _isPressed = false;

  void _launchWhatsApp() {
    launchUrl(Uri.parse(
      widget.linkmessage,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: _launchWhatsApp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: AppConstants.primaryColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/account_icons/whatsapp.svg',
                color: Colors.white,
                height: 30,
              ),
              const SizedBox(width: 8),
              const Text(
                '  Contáctar por WhatsApp',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(180, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
