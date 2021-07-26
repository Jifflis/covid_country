import 'package:covid/model/covid_country.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CovidInfoState{
  const CovidInfoState();
}

class CovidInfoLoaded extends CovidInfoState{
  const CovidInfoLoaded(this.covidCountry);

  final CovidCountry covidCountry;
}

class CovidInfoLoading extends CovidInfoState{

}

class CovidInfoError extends CovidInfoState{

}
class CovidInfoInitialize extends CovidInfoState{

}