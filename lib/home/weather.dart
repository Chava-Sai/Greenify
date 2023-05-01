import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenify/home/profile.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import '../register/login.dart';
import '../screens/chat_screen.dart';
import 'calender.dart';
import 'date.dart';
import 'carboncal.dart';
import 'graph.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}



class _WeatherPageState extends State<WeatherPage> {
  var _highTemp;
  var _lowTemp;
  var _temp;
  var _temp1;

  double _x = 40;
  double _y = 70;

  // Add a function to update the position of the icon
  void _updatePosition(DragUpdateDetails details) {
    setState(() {
      _x += details.delta.dx;
      _y += details.delta.dy;

      // Restrict the icon's movement within the phone borders
      final Size size = MediaQuery.of(context).size;
      final double maxX = size.width - 50;
      final double maxY = size.height - 50;
      final double minX = 0;
      final double minY = 0;

      if (_x > maxX) {
        _x = maxX;
      } else if (_x < minX) {
        _x = minX;
      }

      if (_y > maxY) {
        _y = maxY;
      } else if (_y < minY) {
        _y = minY;
      }
    });
  }


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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child : Scaffold(
            body: Stack(
              children: [
                if (_temp != null && _temp > 28)
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('Assets/image/back4.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (_temp != null && _temp >= 26 && _temp < 28)
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('Assets/image/back4.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (_temp != null && _temp < 10)
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/rainy.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Positioned(
                  top: 50,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    icon: Icon(
                      // logout button
                      Icons.logout_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 80, bottom: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Text(
                              "Dharwad",
                              style: TextStyle(fontSize: 40, color: Colors.black),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '$_temp°C',
                                  style: TextStyle(
                                      fontSize: 35, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.wb_cloudy_outlined),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'H:$_highTemp°C',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'L:$_lowTemp°C',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                DatePage(),
                Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.height * 0.44,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CarbonCalculator(),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightBlueAccent.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.06,
                      top: MediaQuery.of(context).size.height * 0.46,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CarbonCalculator(),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Transform.rotate(
                              angle: 30 * pi / 180, // set the angle in radians
                              child: Image.asset(
                                'Assets/image/carbon.png',
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height * 0.15,
                                // add any other properties you need here
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.52,
                      top: MediaQuery.of(context).size.height * 0.44,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MonthPage(userName: 'Srinivas')),
                          );
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: MonthPage(userName: 'Srinivas',),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightBlueAccent.withOpacity(0.2),
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.56,
                      top: MediaQuery.of(context).size.height * 0.46,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MonthPage(userName: 'Srinivas')),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'Assets/image/calendar.png',
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.15,
                              // add any other properties you need here
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.height * 0.67,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: GraphApp(),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightBlueAccent.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.08,
                      top: MediaQuery.of(context).size.height * 0.56,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: GraphApp(),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'Assets/image/chart-line-up.png',
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.42,
                              // add any other properties you need here
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.52,
                      top: MediaQuery.of(context).size.height * 0.67,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(username: "Srinivas", email: "srinivassaichava@gmail.com", phoneNumber: "7416413438", onLogout: () {Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                      (route) => false,
                                );})),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightBlueAccent.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.57,
                      top: MediaQuery.of(context).size.height * 0.56,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(username: "Srinivas", email: "srinivassaichava@gmail.com", phoneNumber: "7416413438", onLogout: () {Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                      (route) => false,
                                );})),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'Assets/image/profile.png',
                              width: MediaQuery.of(context).size.width * 0.38,
                              height: MediaQuery.of(context).size.height * 0.42,
                              // add any other properties you need here
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: _x,
                  top: _y,
                  child: GestureDetector(
                    onPanUpdate: _updatePosition,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                    child: Icon(
                      Icons.chat,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),

              ],
            ),
          ),
      ),
    );
  }
}
