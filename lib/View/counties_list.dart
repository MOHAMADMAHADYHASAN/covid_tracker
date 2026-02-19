import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'countries_List_Detiels.dart';
import '../Model/CountriesModel.dart';
import '../Services/states_GET_services.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _controller = TextEditingController();
  late Future<List<CountriesModel>> initCountriesList;

  List<StatesGetServices> newCountriesList = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    ///.........get request page er object create..................
    StatesGetServices statesGetServices = StatesGetServices();
    //
    initCountriesList = statesGetServices.getCountriesListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            //// this is search bar...........................................
            child: TextFormField(
              controller: _controller,
              // name search dewar por state change hobe
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search bar ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.tealAccent))),
            ),
          ),
          Expanded(
              //future builber ::
              child: FutureBuilder(

                  ///object call
                  future: initCountriesList,
                  builder:
                      (context, AsyncSnapshot<List<CountriesModel>> snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            //shimmer effect for loading countries data......
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.white54),
                                      title: Container(
                                        height: 20,
                                        width: double.infinity,
                                        color: Colors.white54,
                                      ),
                                      subtitle: Container(
                                        height: 20,
                                        width: double.infinity,
                                        color: Colors.white54,
                                      ),
                                    )
                                  ],
                                ));
                          });
                    }

                    /// error show
                    else if (snapShot.hasError) {
                      return Text("${snapShot.error}");
                    } // show data Countries flag,cases  in a list
                    else {
                      return ListView.builder(
                          itemCount: snapShot.data!.length,
                          itemBuilder: (context, index) {
                            // variable (name) for  handeling seacrh bar........
                            String? name = snapShot.data![index].country;
                            if (_controller.text.isEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CountriesListDetiels(
                                                name: snapShot
                                                    .data![index].country
                                                    .toString(),
                                                image: snapShot.data![index]
                                                    .countryInfo!.flag
                                                    .toString(),
                                                cases: snapShot
                                                        .data![index].cases ??
                                                    0,
                                                deaths: snapShot
                                                        .data![index].deaths ??
                                                    0,
                                                recovered: snapShot.data![index]
                                                        .recovered ??
                                                    0,
                                                active: snapShot
                                                        .data![index].active ??
                                                    0,
                                                critical: snapShot.data![index]
                                                        .critical ??
                                                    0,
                                              )));
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapShot
                                              .data![index].countryInfo!.flag
                                              .toString())),
                                      title:
                                          Text(snapShot.data![index].country!),
                                      subtitle: Text("cases:" +
                                          snapShot.data![index].cases
                                              .toString()),
                                    ),
                                    Divider()
                                  ],
                                ),
                              );
                            } else if (name!
                                .toLowerCase()
                                .contains(_controller.text.toLowerCase())) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CountriesListDetiels(
                                                name: snapShot
                                                    .data![index].country
                                                    .toString(),
                                                image: snapShot.data![index]
                                                    .countryInfo!.flag
                                                    .toString(),
                                                cases: snapShot
                                                        .data![index].cases ??
                                                    0,
                                                deaths: snapShot
                                                        .data![index].deaths ??
                                                    0,
                                                recovered: snapShot.data![index]
                                                        .recovered ??
                                                    0,
                                                active: snapShot
                                                        .data![index].active ??
                                                    0,
                                                critical: snapShot.data![index]
                                                        .critical ??
                                                    0,
                                              )));
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapShot
                                              .data![index].countryInfo!.flag
                                              .toString())),
                                      title:
                                          Text(snapShot.data![index].country!),
                                      subtitle: Text("cases:" +
                                          snapShot.data![index].cases
                                              .toString()),
                                    ),
                                    Divider()
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                    ////
                  }))
        ],
      )),
    );
  }
}
