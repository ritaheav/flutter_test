import 'package:flutter/material.dart';
import 'package:flutter_weather_test/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_test/model/weather.dart';
import 'package:flutter_weather_test/utils/weather_icon.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class DetailScreen extends StatelessWidget {

  const DetailScreen({Key key, @required this.item}) : super(key: key);
  final Weather item;

  @override
  Widget build(BuildContext context) {
    print(item.description);
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat('EEEE, d MMMM yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(item.time * 1000)
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    item.getIconData(),
                    size: 70,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  item.cityName != null ? Text(
                    item.cityName,
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                    ),
                  ) : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    DateFormat.Hm().format(
                        DateTime.fromMillisecondsSinceEpoch(item.time * 1000)),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${(item.temperature - 273.15).floor()}°', style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue),),
                        Container(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.blue,
                          ),
                        ),
                        Text(item.description, style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue),)
                      ]
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                          children: <Widget>[
                            Icon(
                              WeatherIcons.humidity,
                              color: Colors.yellow,
                              size: 50,
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${item.humidity}%',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ]
                      ),
                      Column(
                          children: <Widget>[
                            Icon(
                              WeatherIcons.visibility,
                              color: Colors.yellow,
                              size: 50,
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${item.visibility/1000} km',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ]
                      ),
                      Column(
                          children: <Widget>[
                            Icon(
                              WeatherIcons.pressure,
                              color: Colors.yellow,
                              size: 50,
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${item.pressure} hPa',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ]
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                            children: <Widget>[
                              Icon(
                                WeatherIcons.wind,
                                color: Colors.yellow,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                '${item.windSpeed} km/h',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ]
                        ),
                        Column(
                            children: <Widget>[
                              Icon(
                                WeatherIcons.cloud,
                                color: Colors.yellow,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                '${item.clouds} %',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ]
                        )
                      ]
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String text = 'date: ${DateFormat('EEEE, d MMMM yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(item.time * 1000))}; time: ${DateFormat.Hm().format(
                          DateTime.fromMillisecondsSinceEpoch(item.time * 1000))}; temperature: ${
                          (item.temperature - 273.15).floor()}°; description: ${
                          item.description}; humidity:${item.humidity}%; visibility: ${
                          item.visibility/1000} km; pressure: ${item.pressure} hPa; windSpeed: ${
                          item.windSpeed} km/h; clouds: ${item.clouds} %';
                      Share.share(text);
                    },
                    child: Text('Share', style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(32, 195, 175, 1)),
                    ),
                  )
                ],
              )
          ),
        );
      },
    );
  }
}