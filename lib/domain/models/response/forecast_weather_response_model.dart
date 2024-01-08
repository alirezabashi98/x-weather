

class ForecastWeatherResponseModel {
  final int dt;
  final MainResponseModel main;
  final List<ForecastWeatherResponseModel> weather;
  final CloudsResponseModel clouds;
  final WindResponseModel wind;
  final VisibilityResponseModel visibility;
  final ResponseModel pop;
  final SysResponseModel sys;
  final String dtTxt;

  ForecastWeatherResponseModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastWeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return ForecastWeatherResponseModel(
      dt: json['dt'],
      main: MainResponseModel.fromJson(json['main']),
      weather: json['weather'].map((e) => ForecastWeatherResponseModel.fromJson(e)).toList(),
      clouds: CloudsResponseModel.fromJson(json['clouds']),
      wind: WindResponseModel.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'],
      sys: SysResponseModel.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }
}

class MainResponseModel {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  MainResponseModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainResponseModel.fromJson(Map<String, dynamic> json) {
    return MainResponseModel(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'],
    );
  }
}

class CloudsResponseModel {
  final int all;

  CloudsResponseModel({
    required this.all,
  });

  factory CloudsResponseModel.fromJson(Map<String, dynamic> json) {
    return CloudsResponseModel(
      all: json['all'],
    );
  }
}

class WindResponseModel {
  final double speed;
  final int deg;
  final double gust;

  WindResponseModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory WindResponseModel.fromJson(Map<String, dynamic> json) {
    return WindResponseModel(
      speed: json['speed'],
      deg: json['deg'],
      gust: json['gust'],
    );
  }
}

class VisibilityResponseModel {
  final int value;

  VisibilityResponseModel({
    required this.value,
  });

  factory VisibilityResponseModel.fromJson(Map<String, dynamic> json) {
    return VisibilityResponseModel(
      value: json['value'],
    );
  }
}

class ResponseModel {
  final double value;

  ResponseModel({
    required this.value,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      value: json['pop'],
    );
  }
}

class SysResponseModel {
  final String pod;

  SysResponseModel({
    required this.pod,
  });

  factory SysResponseModel.fromJson(Map<String, dynamic> json) {
    return SysResponseModel(
      pod: json['pod'],
    );
  }
}
