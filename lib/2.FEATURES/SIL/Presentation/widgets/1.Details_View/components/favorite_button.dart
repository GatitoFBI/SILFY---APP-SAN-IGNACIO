// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _buildCircleIcon(
        iconPath:
            isFavorite ? 'assets/icons/button_icons/corazon_con.svg' : 'assets/icons/button_icons/corazon_sin.svg',
      ),
    );
  }

  Widget _buildCircleIcon({required String iconPath}) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 37,
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          color: Colors.black,
        ),
      ),
    );
  }
}
