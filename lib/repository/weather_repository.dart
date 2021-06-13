import 'package:flutter_weather_test/api/weather_api.dart';
import 'package:flutter_weather_test/model/weather.dart';
import 'package:meta/meta.dart';

class WeatherRepository {
  final WeatherApi weatherApi;
  WeatherRepository({@required this.weatherApi})
      : assert(weatherApi != null);

  Future<Weather> getWeather(String cityName,
      {double latitude, double longitude}) async {
    if (cityName == null) {
      cityName = await weatherApi.getCityNameFromLocation(
          latitude: latitude, longitude: longitude);
    }
    var weather = await weatherApi.getWeatherData(cityName);
    var weathers = await weatherApi.getForecast(cityName);
    weather.forecast = weathers;
    return weather;
  }
}