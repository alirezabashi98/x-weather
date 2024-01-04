class WeatherResponseModel {
  final CoordResponseModel? coord;
  final List<WeatherInfoResponseModel>? weather;
  final String? base;
  final MainResponseModel? main;
  final int? visibility;
  final WindResponseModel? wind;
  final CloudsResponseModel? clouds;
  final int? dt;
  final SysResponseModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  WeatherResponseModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      WeatherResponseModel(
        coord: CoordResponseModel.fromJson(json['coord']),
        weather: json['weather'] != null
            ? json['weather']
                .map<WeatherInfoResponseModel>(
                    (json) => WeatherInfoResponseModel.fromJson(json))
                .toList()
            : [],
        base: json['base'],
        main: MainResponseModel.fromJson(json['main']),
        visibility: json['visibility'],
        wind: WindResponseModel.fromJson(json['wind']),
        clouds: CloudsResponseModel.fromJson(json['clouds']),
        dt: json['dt'],
        sys: SysResponseModel.fromJson(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod'],
      );
}

class WeatherInfoResponseModel {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const WeatherInfoResponseModel(
      {this.id, this.main, this.description, this.icon});

  factory WeatherInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      WeatherInfoResponseModel(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );
}

class SysResponseModel {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  const SysResponseModel(
      {this.type, this.id, this.country, this.sunrise, this.sunset});

  factory SysResponseModel.fromJson(Map<String, dynamic> json) =>
      SysResponseModel(
        type: json['type'],
        id: json['id'],
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );
}

class WindResponseModel {
  final int? speed;
  final int? deg;

  const WindResponseModel({this.speed, this.deg});

  factory WindResponseModel.fromJson(Map<String, dynamic> json) =>
      WindResponseModel(
        speed: double.parse(json['speed'].toString()).round() ,
        deg: double.parse(json['deg'].toString()).round(),
      );
}

class MainResponseModel {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  const MainResponseModel({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });
  factory MainResponseModel.fromJson(Map<String, dynamic> json) =>
      MainResponseModel(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity'],
      );
}

class CoordResponseModel {
  final String? lon;
  final String? lat;

  const CoordResponseModel({this.lon, this.lat});

  factory CoordResponseModel.fromJson(Map<String, dynamic> json) =>
      CoordResponseModel(
        lon: json['lon'].toString(),
        lat: json['lat'].toString(),
      );
}

class CloudsResponseModel {
  final int? all;

  const CloudsResponseModel({this.all});

  factory CloudsResponseModel.fromJson(Map<String, dynamic> json) =>
      CloudsResponseModel(all: json['all']);
}
