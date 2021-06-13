import 'package:flutter/material.dart';
import 'package:flutter_weather_test/api/api_key.dart';
import 'package:flutter_weather_test/screens/weather_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_test/bloc/bloc.dart';
import 'package:flutter_weather_test/api/weather_api.dart';
import 'package:flutter_weather_test/repository/weather_repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApi: WeatherApi(
        httpClient: http.Client(),
        apiKey: ApiKey.OPEN_WEATHER_MAP,
      )
  );

  runApp(MyApp(weatherRepository: weatherRepository));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherScreen(),
      ),
    );
  }
}