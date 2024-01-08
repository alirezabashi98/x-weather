

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
      temp: double.parse(json['main']['temp'].toString()).round(),
      icon: json['weather'][0]['icon'],
      dtTxt: json['dt_txt'],
    );
  }
}
