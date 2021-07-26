import 'dart:convert';

import 'package:covid/model/infected_region.dart';

import 'covid_case.dart';

class CovidCountry extends CovidCase {
  CovidCountry({
    this.country,
    this.moreDataUrl,
    this.lastupdate,
    this.hospitalized,
    this.totalIcu,
    this.availbleHospitalBeds,
    this.availbleIcuBeds,
    String infected='n/a',
    String tested = 'n/a',
    String recovered = 'n/a',
    String deceased = 'n/a',
    String active = 'n/a',
    List<dynamic>? regions,
  }) :super(infected: infected,
    tested: tested,
    recovered: recovered,
    deceased: deceased,
    active: active){

    setCovidInfo();
  }

  String? country;
  DateTime? lastupdate;
  String? hospitalized;
  String? totalIcu;
  String? availbleHospitalBeds;
  String? availbleIcuBeds;
  String? moreDataUrl;

  List<Map<String, dynamic>> covidInfo = [];
  List<InfectedRegion> infectedRegions = [];

  static CovidCountry fromJson(Map<String, dynamic> map) {
    return CovidCountry(
      country: map['country'],
      lastupdate: DateTime.tryParse(map['lastUpdatedSource']??''),
      hospitalized: map['totalHospitalized']?.toString()??'n/a',
      totalIcu: map['totalIcu']?.toString()??'n/a',
      availbleHospitalBeds: map['availbleHospitalBeds']?.toString()??'n/a',
      availbleIcuBeds: map['availbleIcuBeds']?.toString()??'n/a',
      infected: map['infected']?.toString()??'n/a',
      tested: map['tested']?.toString()??'n/a',
      recovered: map['recovered']?.toString()??'n/a',
      deceased: map['deceased']?.toString()??'n/a',
      active: map['active']?.toString()??'n/a',
      moreDataUrl: map['moreData'],
    );
  }

  void setCovidInfo(){
    covidInfo = [
      {'infected': infected},
      {'tested': tested},
      {'recovered': recovered},
      {'deceased': deceased},
    ];
  }

  @override
  String toString() {
    return 'CovidCountry{country: $country, lastupdate: $lastupdate, hospitalized: $hospitalized, totalIcu: $totalIcu, availbleHospitalBeds: $availbleHospitalBeds, availbleIcuBeds: $availbleIcuBeds, moreDataUrl: $moreDataUrl,infected: $infected}';
  }
}