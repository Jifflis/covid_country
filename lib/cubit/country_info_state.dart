import 'package:covid/model/country.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CountryInfoState{
  const CountryInfoState();
}

class CountryInfoInitialize extends CountryInfoState{}

class CountryInfoLoading extends CountryInfoState{}
class CountryInfoError extends CountryInfoState{}
class CountryInfoLoaded extends CountryInfoState{
  const CountryInfoLoaded(this.country);

  final Country country;
}