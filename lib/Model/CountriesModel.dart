class CountriesModel {
  CountriesModel({
    this.updated,
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.population,
    this.continent,
    this.oneCasePerPeople,
    this.oneDeathPerPeople,
    this.oneTestPerPeople,
    this.activePerOneMillion,
    this.recoveredPerOneMillion,
    this.criticalPerOneMillion,
  });

  CountriesModel.fromJson(dynamic json) {
    updated = json['updated'];
    country = json['country'];
    countryInfo = json['countryInfo'] != null
        ? CountryInfo.fromJson(json['countryInfo'])
        : null;
    cases = json['cases'];
    todayCases = json['todayCases'];
    deaths = json['deaths'];
    todayDeaths = json['todayDeaths'];
    recovered = json['recovered'];
    todayRecovered = json['todayRecovered'];
    active = json['active'];
    critical = json['critical'];
    casesPerOneMillion =
        json['casesPerOneMillion']; // int/double দুটোই হতে পারে
    deathsPerOneMillion =
        json['deathsPerOneMillion']; // int/double দুটোই হতে পারে
    tests = json['tests'];
    testsPerOneMillion = json['testsPerOneMillion'];
    population = json['population'];
    continent = json['continent'];
    oneCasePerPeople = json['oneCasePerPeople'];
    oneDeathPerPeople = json['oneDeathPerPeople'];
    oneTestPerPeople = json['oneTestPerPeople'];

    // ✅ এখানে .toDouble() দেওয়া জরুরি
    activePerOneMillion = json['activePerOneMillion']?.toDouble();
    recoveredPerOneMillion = json['recoveredPerOneMillion']?.toDouble();
    criticalPerOneMillion = json['criticalPerOneMillion']?.toDouble();
  }

  int? updated;
  String? country;
  CountryInfo? countryInfo;
  int? cases;
  int? todayCases;
  int? deaths;
  int? todayDeaths;
  int? recovered;
  int? todayRecovered;
  int? active;
  int? critical;
  num? casesPerOneMillion;
  num? deathsPerOneMillion;
  int? tests;
  int? testsPerOneMillion;
  int? population;
  String? continent;
  int? oneCasePerPeople;
  int? oneDeathPerPeople;
  int? oneTestPerPeople;
  double? activePerOneMillion;
  double? recoveredPerOneMillion;
  double? criticalPerOneMillion;
}

class CountryInfo {
  CountryInfo({
    this.id,
    this.iso2,
    this.iso3,
    this.lat,
    this.long,
    this.flag,
  });

  CountryInfo.fromJson(dynamic json) {
    id = json['_id'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];

    lat = json['lat']?.toDouble();
    long = json['long']?.toDouble();

    flag = json['flag'];
  }

  int? id;
  String? iso2;
  String? iso3;

  double? lat;
  double? long;

  String? flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['iso2'] = iso2;
    map['iso3'] = iso3;
    map['lat'] = lat;
    map['long'] = long;
    map['flag'] = flag;
    return map;
  }
}
