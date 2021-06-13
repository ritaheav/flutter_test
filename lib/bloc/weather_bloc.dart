import 'package:bloc/bloc.dart';
import 'package:flutter_weather_test/bloc/bloc.dart';
import 'package:flutter_weather_test/repository/weather_repository.dart';
import 'package:flutter_weather_test/api/http_exception.dart';
import 'package:flutter_weather_test/model/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherEmpty());

  @override
  WeatherState get initialState {
    return WeatherEmpty();
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(
            event.cityName,
            latitude: event.latitude,
            longitude: event.longitude);
        yield WeatherLoaded(weather: weather);
      } catch (exception) {
        print(exception);
        if (exception is HTTPException) {
          yield WeatherError(errorCode: exception.code);
        } else {
          yield WeatherError(errorCode: 500);
        }
      }
    }
  }
}