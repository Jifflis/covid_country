class Country{
  Country({
    this.name,
    this.nativeName,
    this.capital,
    this.region,
    this.demonym,
    this.population,
    this.location,
    this.area,
    this.flag,
    this.subRegion,
    this.alpha2Code,
    this.alpha3Code,
    this.cioc,
    this.numericCode,
    this.gini,
});


  String? name;
  String? nativeName;
  String? capital;
  String? alpha2Code;
  String? alpha3Code;
  String? region;
  String? subRegion;
  String? demonym;
  int? population;
  String? location;
  double? area;
  String? flag;
  String? cioc;
  String? numericCode;
  double? gini;

  List<String> timezones = [];
  List<String> borders = [];
  List<Currency> currencies = [];
  List<Language> languages = [];

  static Country fromJson(Map<String, dynamic> map) {

    List<String> timeZones = [];
    List<dynamic> jsonTimeZones = map['timezones'];
    for(final String timeZone in jsonTimeZones){
      timeZones.add(timeZone);
    }

    List<String> borders = [];
    List<dynamic> jsonBorders = map['borders'];
    for(final String border in jsonBorders){
      borders.add(border);
    }

    List<Language> languages = [];
    List<dynamic> jsonLanguages = map['languages'];
    for(final Map<String,dynamic> languageMap in jsonLanguages){
      languages.add(Language.fromJson(languageMap));
    }

    List<Currency> currencies = [];
    List<dynamic> jsonCurrencies = map['currencies'];
    for(final Map<String,dynamic> currencyMap in jsonCurrencies){
      currencies.add(Currency.fromJson(currencyMap));
    }

    return Country(
      name: map['name'],
      nativeName: map['nativeName'],
      capital: map['capital'],
      region: map['region'],
      demonym: map['denonym'],
      population: map['population'],
      location: map['location'],
      area: map['area'],
      flag: map['flag'],
      gini: map['gini'],
      alpha2Code: map['alpha2Code'],
      alpha3Code: map['alpha3Code'],
      subRegion: map['subRegion'],
      cioc: map['cioc'],
      numericCode: map['numericCode']
    )
      ..timezones =timeZones
      ..borders = borders
      ..languages = languages
      ..currencies = currencies;
  }

  @override
  String toString() {
    return 'Country{name: $name, nativeName: $nativeName, capital: $capital, region: $region, demonym: $demonym, population: $population, location: $location, area: $area, flag: $flag, timezones: $timezones, borders: $borders, currencies: $currencies, languages: $languages}';
  }
}

class Currency{
  Currency({this.code,this.name,this.symbol});

  String? code;
  String? name;
  String? symbol;

  static Currency fromJson(Map<String, dynamic> map) {
    return Currency(
      code: map['code'],
      name: map['name'],
      symbol: map['symbol'],
    );
  }
}

class Language {
  Language({this.iso639_1,this.iso639_2,this.name,this.nativeName});

  String? iso639_1;
  String? iso639_2;
  String? name;
  String? nativeName;

  static Language fromJson(Map<String, dynamic> map) {
    return Language(
      iso639_1: map['iso639_1'],
      iso639_2: map['iso639_2'],
      name: map['name'],
      nativeName: map['nativeName'],
    );
  }
}

