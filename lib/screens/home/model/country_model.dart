final String tableCountry = 'country';

class CountryFields {
  static final List<String> values = [id, name, region, flagUrl, capital];

  static final String id = '_id';
  static final String name = 'name';
  static final String region = 'region';
  static final String flagUrl = 'flag_url';
  static final String capital = 'capital';
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.region,
    required this.flagUrl,
    required this.capital,
    this.languageListString,
    this.borderListString,
  });

  String id;
  String name;
  String region;
  String flagUrl;
  String capital;
  String? languageListString;
  String? borderListString;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
      id: json["cca3"],
      name: json["name"]["common"],
      region: json["region"],
      flagUrl: json["flags"]["png"],
      capital: json["capital"] != null ? json["capital"][0] ?? '' : '',
      languageListString: json["languages"] != null && json["languages"].values != null
          ? json["languages"].values.toList().toString()
          : '',
      borderListString: json["borders"].toString());

  factory Country.fromDBJson2(Map<String, dynamic> json) => Country(
        id: json[CountryFields.id],
        name: json[CountryFields.name],
        region: json[CountryFields.region],
        flagUrl: json[CountryFields.flagUrl],
        capital: json[CountryFields.capital],
      );

  Map<String, Object?> toJson() => {
        CountryFields.id: id,
        CountryFields.name: name,
        CountryFields.region: region,
        CountryFields.flagUrl: flagUrl,
        CountryFields.capital: capital,
      };
}

List<Country> countryFromJson(var responseJson) {
  return responseJson.map<Country>((data) => Country.fromJson(data)).toList();
}
