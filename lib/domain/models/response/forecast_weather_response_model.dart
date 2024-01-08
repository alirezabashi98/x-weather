

class ForecastWeatherResponseModel {
  final int temp;
  final String icon;
  final String dtTxt;

  ForecastWeatherResponseModel({
    required this.temp,
    required this.icon,
    required this.dtTxt,
  });

  factory ForecastWeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return ForecastWeatherResponseModel(
      temp: json['main']['main'],
      icon: json['weather'][0]['icon'],
      dtTxt: json['dt_txt'],
    );
  }
}
