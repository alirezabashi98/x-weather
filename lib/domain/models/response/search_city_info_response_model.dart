class SearchCityInfoResponseModel {
  String city;
  String country;
  String regionCode;
  String latitude;
  String longitude;

  SearchCityInfoResponseModel(
    this.city,
    this.country,
    this.regionCode,
    this.latitude,
    this.longitude,
  );

  factory SearchCityInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchCityInfoResponseModel(
        json['city'],
        json['country'],
        json['regionCode'],
        json['latitude'].toString(),
        json['longitude'].toString(),
      );
}
