import 'package:flutter_weather_test/model/weather.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final int errorCode;

  WeatherError({this.errorCode}) : assert(errorCode != null);

  @override
  List<Object> get props => [errorCode];
}