import 'package:flutter/material.dart';
import 'package:flutter_weather_test/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_weather_test/widgets/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  WeatherBloc _weatherBloc;
  String _cityName = 'Minsk';
  Animation<double> _fadeAnimation;
  AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    _fetchWeatherWithLocation().catchError((error) {
      _fetchWeatherWithCity();
    });

    _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Material(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(color: Colors.white),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (_, WeatherState weatherState) {
                    _fadeController.reset();
                    _fadeController.forward();

                    if (weatherState is WeatherLoaded) {
                      this._cityName = weatherState.weather.cityName;
                      return WeatherWidget(
                        weather: weatherState.weather,
                      );
                    } else if (weatherState is WeatherError ||
                        weatherState is WeatherEmpty) {
                      String errorText = 'При получении данных о погоде произошла ошибка.';
                      if (weatherState is WeatherError) {
                        if (weatherState.errorCode == 404) {
                          errorText =
                          'У нас проблемы с получением погоды для $_cityName';
                        }
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            errorText,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.green,
                              elevation: 1,
                            ),
                            child: Text("Попробовать опять"),
                            onPressed: _fetchWeatherWithCity,
                          )
                        ],
                      );
                    } else if (weatherState is WeatherLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }
                    return Container(
                      child: Text('Город не указан'),
                    );
                  }),
            ),
          ),
        ));
  }

  _fetchWeatherWithCity() {
    _weatherBloc.add(FetchWeather(cityName: _cityName));
  }

  _fetchWeatherWithLocation() async {
    var permissionResult = await Permission.locationWhenInUse.status;

    switch (permissionResult) {
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        print('разрешение на местоположение отказано');
        _showLocationDeniedDialog();
        break;

      case PermissionStatus.denied:
        await Permission.locationWhenInUse.request();
        _fetchWeatherWithLocation();
        break;

      case PermissionStatus.limited:
      case PermissionStatus.granted:
        print('получение местоположения');
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
            timeLimit: Duration(seconds: 2));

        print(position.toString());

        _weatherBloc.add(FetchWeather(
          longitude: position.longitude,
          latitude: position.latitude,
        ));
        break;
    }
  }

  void _showLocationDeniedDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {

          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Местоположение отключено',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                child: Text('Включить'),
                style: TextButton.styleFrom(
                  primary: Colors.grey,
                  elevation: 1,
                ),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}