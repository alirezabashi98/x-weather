import 'package:flutter/material.dart';
import 'package:x_weather/utils/constants/constants.dart';

import '../../assets/assets.dart';

class ItemWeatherData extends StatelessWidget {
  const ItemWeatherData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 32),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_item_weather.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: double.infinity, height: 32),
                  Text(
                    '32\u00B0',
                    style: TextStyle(fontSize: 64, color: Constants.primary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '09:27',
                    style: TextStyle(color: Constants.secondary, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Tehran',
                    style: TextStyle(color: Constants.primary, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(AssetsData.light().images.ic_10d_png)),
          ),
        ],
      ),
    );
  }
}
