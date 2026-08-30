// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../1.CONFIG/Core/constants/app_constants.dart';

class AppButton extends StatelessWidget {
  final double widthIcon; //40.
  final String label;
  final double roundness;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final String? trailingIconPath;
  final Function? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  const AppButton({
    super.key,
    required this.label,
    this.roundness = 18,
    this.fontWeight = FontWeight.bold,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
    this.trailingIconPath,
    this.onPressed,
    this.backgroundColor = AppConstants.primaryColor,
    this.iconColor,
    this.widthIcon = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () => onPressed?.call(),
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(roundness),
          ),
          elevation: 0,
          backgroundColor: backgroundColor,
          textStyle: TextStyle(
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
            fontWeight: fontWeight,
            color: Colors.white,
          ),
          padding: padding,
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (trailingIconPath != null)
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: SizedBox(
                  width: widthIcon,
                  height: widthIcon,
                  child: SvgPicture.asset(
                    color: iconColor,
                    trailingIconPath!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: fontWeight,
                    color: const Color.fromARGB(180, 255, 255, 255),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
