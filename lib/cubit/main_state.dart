import 'package:covid/model/covid_country.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MainState{
  const MainState();
}

class MainLoading extends MainState{}

class MainError extends MainState{
  MainError(this.error);

  final String error;
}

class MainLoaded extends MainState{

  const MainLoaded(this.covidCountries);

  final List<CovidCountry> covidCountries;
}
