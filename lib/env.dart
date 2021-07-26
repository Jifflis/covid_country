import 'dart:convert';

import 'package:flutter/services.dart';

class Env {

  String tag = 'env';

  static Map<String, dynamic>? _env;

  static Future<void> initEnv() async {
    _env = json.decode(await rootBundle.loadString('.env'));
  }

  /// Get API Url.
  ///
  static String get covidCountryUrl => _env ?['covid_country_url'];


  /// Get Country Url.
  ///
  static String get countryUrl => _env ?['country_url'];
}