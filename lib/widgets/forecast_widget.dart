import 'package:flutter/material.dart';
import 'package:flutter_weather_test/model/weather.dart';
import 'package:flutter_weather_test/widgets/value_tile.dart';
import 'package:intl/intl.dart';

class ForecastHorizontal extends StatelessWidget {
  const ForecastHorizontal({
    Key key,
    @required this.weathers,
  }) : super(key: key);

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {

    return Container(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => Divider(
            height: 80,
            color: Color(0xFFDFDFDF),
          ),
          itemCount: this.weathers.length,
          itemBuilder: (context, index) {
            final item = this.weathers[index];
            return Column(
                children: <Widget>[
                  (index != this.weathers.length-1 && this.weathers[index].dt_txt.substring(0, 10) != this.weathers[index+1].dt_txt.substring(0, 10)) ? ListTile(
                      title: Text(DateFormat.EEEE().format(
                        DateTime.fromMillisecondsSinceEpoch(item.time * 1000),
                      ))
                  ) : Container(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                        child: ValueTile(
                          DateFormat.Hm().format(
                              DateTime.fromMillisecondsSinceEpoch(item.time * 1000)),
                          '${(item.temperature - 273.15).floor()}°',
                          '${item.description}',
                          iconData: item.getIconData(),
                        )),
                  )
                ]
            );
          },
        )
    );
  }
}