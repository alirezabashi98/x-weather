import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:x_weather/utils/constants/constants.dart';

class CustomLoading extends StatelessWidget {
  final Color? color;
  final double? size;
  const CustomLoading({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.fourRotatingDots(
      color: color ?? Constants.solid3,
      size: size ?? 32,
    );
  }
}
