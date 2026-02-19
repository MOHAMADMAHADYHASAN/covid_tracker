import 'dart:convert';

import 'package:covid_tracker/Model/CountriesModel.dart';
import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesGetServices {
  Future<WorldStatesModel> featchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("error");
    }
  }

  //--------------------------.........................

  Future<List<CountriesModel>> getCountriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {

      List<CountriesModel> CountriesLst = [];

      for (var i in data) {
        CountriesLst.add(CountriesModel.fromJson(i));
      }
      return CountriesLst;
    } else {
      throw Exception("Error");
    }
  }
}
