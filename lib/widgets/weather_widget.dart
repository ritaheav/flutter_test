import 'package:flutter/material.dart';
import 'package:flutter_weather_test/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_test/model/weather.dart';
import 'package:flutter_weather_test/widgets/forecast_widget.dart';
import 'package:flutter_weather_test/screens/detail_screen.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (_) =>
                      BlocProvider.value(
                          value: BlocProvider.of<WeatherBloc>(context),
                          child: DetailScreen(item: weather)
                      )
              )
              );
            },
            child: Text('Current weather', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            )
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(32, 195, 175, 1)),
            ),
          ),
          ForecastHorizontal(weathers: weather.forecast),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}