String filteredCountry(String? country) {
  if (country == null) return '';

  String countryName = country;
  if (countryName == 'United Kingdom') {
    countryName = 'UK';
  }
  if (countryName == 'United States') {
    countryName = 'US';
  }
  if (countryName == 'South Korea') {
    countryName = 'KR';
  }
  if (countryName == 'Russia') {
    countryName = 'RU';
  }
  return countryName;
}
