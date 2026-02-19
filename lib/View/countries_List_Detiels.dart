import 'package:flutter/material.dart';

class CountriesListDetiels extends StatefulWidget {
  final String name, image;
  final int cases, deaths, recovered, active, critical;

  const CountriesListDetiels(
      {Key? key,
      required this.name,
      required this.image,
      required this.cases,
      required this.deaths,
      required this.recovered,
      required this.active,
      required this.critical})
      : super(key: key);

  @override
  State<CountriesListDetiels> createState() => _CountriesListDetielsState();
}

class _CountriesListDetielsState extends State<CountriesListDetiels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .05),
                        ReuseableRow2(
                            title: "Total Cases:",
                            value: widget.cases.toString()),
                        ReuseableRow2(
                            title: "Deaths:", value: widget.deaths.toString()),
                        ReuseableRow2(
                            title: "Recovered:",
                            value: widget.recovered.toString()),
                        ReuseableRow2(
                            title: "Active:", value: widget.active.toString()),
                        ReuseableRow2(
                            title: "Critical:",
                            value: widget.critical.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ));
  }
}

class ReuseableRow2 extends StatelessWidget {
  final String title, value;

  ReuseableRow2({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            children: [Text(title), Text(value)],
          ),
          Divider()
        ],
      ),
    );
  }
}
