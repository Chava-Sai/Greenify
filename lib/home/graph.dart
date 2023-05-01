import 'package:flutter/material.dart';
import 'package:greenify/home/weather.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class GraphApp extends StatefulWidget {
  @override
  _GraphAppState createState() => _GraphAppState();
}

class _GraphAppState extends State<GraphApp> {
  late List<SalesData> data;
  late int _todayDay;
  late int _daysInMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _todayDay = DateTime.now().day;
    _daysInMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    _selectedDate = DateTime.now();
    data = [
      SalesData(1, 10.62),
      // SalesData(2, 19.79),
      // SalesData(3, 0.39),
      // SalesData(4, 2.23),
      // SalesData(5, 12.96),
      // SalesData(6, 17.81),
      // SalesData(7, 1.05),
      // SalesData(8, 10.97),
      // SalesData(9, 0.1),
      // SalesData(10, 15.4),
      // SalesData(11, 11.01),
      // SalesData(12, 5.67),
      // SalesData(13, 7.83),
      // SalesData(14, 18.57),
      // SalesData(15, 15.54),
      // SalesData(16, 19.79),
      // SalesData(17, 15.66),
      // SalesData(18, 6.73),
      // SalesData(19, 7.66),
      // SalesData(20, 12.19),
      // SalesData(21, 17.83),
      // SalesData(22, 2.69),
      // SalesData(23, 9.42),
      // SalesData(24, 16.66),
      //SalesData(DateTime.now().day, 0.0) // today's data
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            // set your desired height here
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: WeatherPage(),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Emission Graph',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
              ),
              flexibleSpace: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF00AEEF),
                        Color(0XFF4AC3E3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Select Date :',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 24),
                        ),
                        SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(DateFormat.yMd().format(_selectedDate)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 600,
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                        minimum: DateTime(
                            DateTime.now().year, DateTime.now().month, 1),
                        maximum: _selectedDate,
                        interval: 7,
                        dateFormat: DateFormat.d(),
                        axisLine: AxisLine(width: 3),
                      ),
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 24,
                        interval: 2,
                        axisLine: AxisLine(width: 3),
                        //title: AxisTitle(text: 'Emission in KG'),
                      ),
                      title: ChartTitle(text: 'Monthly Emission values'),
                      series: <LineSeries<SalesData, DateTime>>[
                        LineSeries<SalesData, DateTime>(
                          name:
                              'Carbon Emission \n${DateFormat.MMMM().format(DateTime.now())}',
                          dataSource: data,
                          xValueMapper: (SalesData sales, _) => DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              sales.day),
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelAlignment: ChartDataLabelAlignment.bottom,
                          ),
                          markerSettings: MarkerSettings(isVisible: true),
                        ),
                      ],
                      //legend: Legend(isVisible: false),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    final DateTime lastDayOfMonth =
        DateTime(now.year, now.month + 1, 0).add(Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: firstDayOfMonth,
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      selectableDayPredicate: (DateTime date) {
        return date.isAfter(firstDayOfMonth.subtract(Duration(days: 1))) &&
            date.isBefore(lastDayOfMonth);
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        data[data.length - 1] = SalesData(_selectedDate.day, 0);
      });
    }
  }
}

class SalesData {
  SalesData(this.day, this.sales);

  final int day;
  final double sales;
}
