import 'covid_case.dart';

class InfectedRegion extends CovidCase {
  InfectedRegion({
    this.regionName,
    String infected = 'n/a',
    String tested = 'n/a',
    String recovered = 'n/a',
    String deceased = 'n/a',
    String active = 'n/a',
  }):super(
      infected: infected,
      tested: tested,
      recovered: recovered,
      deceased: deceased,
      active: active
  );

  String? regionName;

  static InfectedRegion fromJson(Map<String, dynamic> json) {
    return InfectedRegion(
      infected: json['infected']?.toString()??'n/a',
      tested: json['tested']?.toString()??'n/a',
      recovered: json['recovered']?.toString()??'n/a',
      deceased: json['deceased']?.toString()??'n/a',
      active: json['active']?.toString()??'n/a',
      regionName: json['region'],
    );
  }

  @override
  String toString() {
    return 'InfectedRegion{regionName: $regionName, infected: $infected}';
  }
}
