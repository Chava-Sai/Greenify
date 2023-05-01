import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

List<DateTime> generateDatesForSixDays() {
  final now = DateTime.now();
  final dateList =
  List<DateTime>.generate(6, (index) => now.add(Duration(days: index + 1)));
  return dateList;
}

class DatePage extends StatefulWidget {
  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  var _highTemp;
  var _lowTemp;
  var _temp;
  var _temp1,_temp2,_temp3,_temp4,_temp5,_temp6;
  var x;
  late int i;

  @override
  void initState() {
    super.initState();
    _getWeatherData();
  }

  void _getWeatherData() async {
    var response =
    await http.get(Uri.https('api.weatherbit.io', '/v2.0/forecast/daily', {
      'lat': '15.4589',
      'lon': '75.0078',
      'key': '9cdbfe08e097475095343c07d7f5cfc5',
    }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _highTemp = data['data'][0]['high_temp'];
        _lowTemp = data['data'][0]['low_temp'];
        _temp = data['data'][0]['temp'];
        _temp1 = data['data'][1]['temp'];
        _temp2 = data['data'][2]['temp'];
        _temp3 = data['data'][3]['temp'];
        _temp4 = data['data'][4]['temp'];
        _temp5 = data['data'][5]['temp'];
        _temp6 = data['data'][6]['temp'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final dateList = generateDatesForSixDays();

    return Stack(
      children: [
        Positioned(
          left: MediaQuery.of(context).size.width * 0.04,
          top: MediaQuery.of(context).size.height * 0.26,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.93,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.lightBlueAccent.withOpacity(0.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: dateList.map((date) {
                    return Text(
                      DateFormat('dd/MM').format(date),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (_temp1 != null && _temp1 >= 28)
                      Icon(Icons.sunny),
                    if (_temp1 != null && _temp1 < 28)
                      Icon(Icons.cloudy_snowing),
                    if (_temp2 != null && _temp2 >= 28)
                      Icon(Icons.sunny),
                    if (_temp2 != null && _temp2 < 28)
                      Icon(Icons.cloudy_snowing),
                    if (_temp3 != null && _temp3 >= 28)
                      Icon(Icons.sunny),
                    if (_temp3 != null && _temp3 < 28)
                      Icon(Icons.cloudy_snowing),
                    if (_temp4 != null && _temp4 >= 28)
                      Icon(Icons.sunny),
                    if (_temp4 != null && _temp4 < 28)
                      Icon(Icons.cloudy_snowing),
                    if (_temp5 != null && _temp5 >= 28)
                      Icon(Icons.sunny),
                    if (_temp5 != null && _temp5 < 28)
                      Icon(Icons.cloudy_snowing),
                    if (_temp6 != null && _temp6 >= 28)
                      Icon(Icons.sunny),
                    if (_temp6 != null && _temp6 < 28)
                      Icon(Icons.cloudy_snowing),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '$_temp1°C',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_temp2°C',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_temp3°C',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_temp4°C',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_temp5°C',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_temp6°C',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have a Good Day',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                    Icon(Icons.emoji_emotions_outlined),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
