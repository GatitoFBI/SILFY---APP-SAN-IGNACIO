import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';

class IntroCard extends StatelessWidget {
  final String title;
  final String description;

  const IntroCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 16, bottom: 20),
      // padding: const EdgeInsets.only(top: 50, left: 40, right: 16, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          AppText(
            text: description,
            fontSize: 16,
            color: Colors.white70,
            // color: Colors.green.shade700,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
