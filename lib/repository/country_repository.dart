import 'dart:convert';

import 'package:covid/model/country.dart';
import 'package:covid/util/string_util.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import 'api.dart';

class CountryRepository {
  factory CountryRepository(ApiProvider apiProvider)=>CountryRepository._(apiProvider);

  CountryRepository._(this.api);

  ApiProvider api;

  Future<Country> getCountryDetails(String? countryName) async {
    final http.Response response = await api
        .get('${Env.countryUrl}${filteredCountry(countryName)}?fullText=true');
    final Map<String, dynamic> data = json.decode(response.body)[0];
    Country country = Country.fromJson(data);

    return country;
  }
}
