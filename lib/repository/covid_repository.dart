import 'dart:convert';

import 'package:covid/model/covid_country.dart';
import 'package:covid/model/infected_region.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import 'api.dart';

class CovidRepository{
  factory CovidRepository(ApiProvider apiProvider)=>CovidRepository._(apiProvider);

  CovidRepository._(this.api);
  ApiProvider api;

  Future<List<CovidCountry>> getInfectedCountries() async{
    final http.Response response = await api.get(Env.covidCountryUrl);
    final List<dynamic> mapList = json.decode(response.body)??[];

    final List<CovidCountry> covidCountries = <CovidCountry>[];

    for(final Map<String,dynamic> map in mapList){
      final CovidCountry country = CovidCountry.fromJson(map);
      covidCountries.add(country);
    }

    return covidCountries;
  }


  Future<CovidCountry> getInfectedCountry(String? url) async{
    print(url);
    final http.Response response = await api.get(url??'');
    final Map<String,dynamic> data = json.decode(response.body);

    print(data.toString());
    CovidCountry country = CovidCountry.fromJson(data);
    final List<dynamic> mapList = data['infectedByRegion']??[];

    List<InfectedRegion> regions = [];
    for(final Map<String,dynamic> map in mapList){
      final InfectedRegion region = InfectedRegion.fromJson(map);
      regions.add(region);
    }

    country.infectedRegions = regions;

    return country;
  }
}