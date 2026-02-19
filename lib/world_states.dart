import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'Model/WorldStatesModel.dart';
import 'Services/states_GET_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'View/counties_list.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  //variable  for store object....................
  late Future<WorldStatesModel> initGetApi;
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff0539f1),
    Color(0xff0daf0a),
    Color(0xffaa0303),
  ];
  final gradientList = <List<Color>>[
    [Color.fromRGBO(27, 75, 113, 1.0), Color.fromRGBO(4, 31, 83, 1.0)],
    [Color.fromRGBO(15, 214, 9, 1.0), Color.fromRGBO(7, 90, 63, 1.0)],
    [Color.fromRGBO(225, 10, 9, 1.0), Color.fromRGBO(126, 7, 7, 1.0)],
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //object create ...................
    StatesGetServices statesGetServices = StatesGetServices();
    initGetApi = statesGetServices.featchWorldStatesRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                // data loading in pi chart:::::::::::::::::
                FutureBuilder(
                  future: initGetApi,
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapShot) {
                    //show........................................
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.green,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    } else if (snapShot.hasError) {
                      return Center(
                        child: Text("error ${snapShot.error.toString()}"),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                snapShot.data!.cases?.toString() ?? "0",
                              ),
                              "Recovered": double.parse(
                                snapShot.data!.recovered?.toString() ?? "0",
                              ),
                              "Death": double.parse(
                                snapShot.data!.deaths?.toString() ?? "0",
                              ),
                            },
                            animationDuration: const Duration(
                              milliseconds: 1200,
                            ),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius:
                                MediaQuery.of(context).size.width / 2.5,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            gradientList: gradientList,
                          ),
                          //card er data show ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06,
                            ),
                            child: Card(

                              child: Column(
                                children: [
                                  ReuseableRow(
                                    title: "Total",
                                    value: snapShot.data!.cases.toString(),
                                  ),
                                  ReuseableRow(
                                    title: "Recovered",
                                    value: snapShot.data!.recovered.toString(),
                                  ),
                                  ReuseableRow(
                                    title: "Deaths",
                                    value: snapShot.data!.deaths.toString(),
                                  ),
                                  ReuseableRow(
                                    title: "Critical",
                                    value: snapShot.data!.critical.toString(),
                                  ),
                                  ReuseableRow(
                                    title: "Today Deaths",
                                    value:
                                        snapShot.data!.todayDeaths
                                            ?.toString() ??
                                        '0',
                                  ),
                                  ReuseableRow(
                                    title: "Today recovered",
                                    value:
                                        snapShot.data!.todayRecovered
                                            ?.toString() ??
                                        "0",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountriesListScreen(),
                                ),
                              );
                            },
                            child: Text("Track Countries"),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;

  ReuseableRow({Key? key, required this.title, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
