import 'dart:convert';

final String tableCountry = 'country';

class CountryFields {
  static final List<String> values = [id, name, region, flagUrl, capital, languages];

  static final String id = '_id';
  static final String name = 'name';
  static final String region = 'region';
  static final String flagUrl = 'flag_url';
  static final String capital = 'capital';
  static final String languages = 'languages';
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.region,
    required this.flagUrl,
    required this.capital,
    this.languages,
    this.borderList,
  });

  String id;
  String name;
  String region;
  String flagUrl;
  String capital;
  Map<String, dynamic>? languages;
  List? borderList;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
      id: json["cca3"],
      name: json["name"]["common"],
      region: json["region"],
      flagUrl: json["flags"]["png"],
      capital: json["capital"] != null ? json["capital"][0] ?? '' : '',
      languages: json["languages"] != null ? json["languages"] : {},
      borderList: json["borders"] != null ? json["borders"].toList() : []);

  factory Country.fromDBJson2(Map<String, dynamic> json) => Country(
        id: json[CountryFields.id],
        name: json[CountryFields.name],
        region: json[CountryFields.region],
        flagUrl: json[CountryFields.flagUrl],
        capital: json[CountryFields.capital],
        languages: jsonDecode(json[CountryFields.languages]),
      );

  Map<String, Object?> toJson() => {
        CountryFields.id: id,
        CountryFields.name: name,
        CountryFields.region: region,
        CountryFields.flagUrl: flagUrl,
        CountryFields.capital: capital,
        CountryFields.languages: jsonEncode(languages),
      };
}

List<Country> countryFromJson(var responseJson) {
  return responseJson.map<Country>((data) => Country.fromJson(data)).toList();
}
