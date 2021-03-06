import 'package:flutter/material.dart';
import 'package:flutter_weather_test/utils/weather_icon.dart';
import 'package:flutter_weather_test/utils/converters.dart';

class Weather {
  int id;
  int time;
  int clouds;
  int pressure;
  int humidity;
  String description;
  String iconCode;
  String main;
  String cityName;
  double windSpeed;
  double temperature;
  List<Weather> forecast;
  String dt_txt;
  double visibility;

  Weather(
      {this.id,
        this.time,
        this.clouds,
        this.pressure,
        this.humidity,
        this.description,
        this.iconCode,
        this.main,
        this.cityName,
        this.windSpeed,
        this.temperature,
        this.forecast,
        this.dt_txt,
        this.visibility});

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: intToDouble(json['main']['temp']),
      clouds: json['clouds']['all'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
      dt_txt: json['dt_txt'],
      visibility: intToDouble(json['visibility']),
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = List<Weather>();
    for (final item in json['list']) {
      print(json['list']);
      weathers.add(Weather(
        time: item['dt'],
        temperature: intToDouble(
          item['main']['temp'],
        ),
        description: item['weather'][0]['description'],
        iconCode: item['weather'][0]['icon'],
        dt_txt: item['dt_txt'],
        clouds: item['clouds']['all'],
        pressure: item['main']['pressure'],
        humidity: item['main']['humidity'],
        windSpeed: intToDouble(item['wind']['speed']),
        visibility: intToDouble(item['visibility']),
      ));
    }
    return weathers;
  }

  IconData getIconData(){
    switch(this.iconCode){
      case '01d': return WeatherIcons.clear_day;
      case '01n': return WeatherIcons.clear_night;
      case '02d': return WeatherIcons.few_clouds_day;
      case '02n': return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d': return WeatherIcons.shower_rain_day;
      case '09n': return WeatherIcons.shower_rain_night;
      case '10d': return WeatherIcons.rain_day;
      case '10n': return WeatherIcons.rain_night;
      case '11d': return WeatherIcons.thunder_storm_day;
      case '11n': return WeatherIcons.thunder_storm_night;
      case '13d': return WeatherIcons.snow_day;
      case '13n': return WeatherIcons.snow_night;
      case '50d': return WeatherIcons.mist_day;
      case '50n': return WeatherIcons.mist_night;
      default: return WeatherIcons.clear_day;
    }
  }
}
