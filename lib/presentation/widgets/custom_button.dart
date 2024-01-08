import 'package:flutter/material.dart';
import 'package:x_weather/utils/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? text;
  final Widget? icon;
  final String? textMessage;
  final IconData? iconData;
  final Function() onTap;
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      this.text,
      this.textMessage,
      this.icon,
      this.iconData,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 100,
        height: height ?? 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Constants.tertiary),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon ??
                  Icon(
                    iconData ?? Icons.ads_click,
                    color: Colors.white,
                  ),
              const SizedBox(width: 4),
              text ??
                  Text(
                    textMessage ?? 'click here',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
