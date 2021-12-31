import 'dart:convert';

class Country {
  Country({
    required this.id,
    required this.name,
    required this.region,
    required this.flagUrl,
    required this.capital,
    required this.languageListString,
    required this.borderListString,
  });

  String id;
  String name;
  String region;
  String flagUrl;
  String capital;
  String languageListString;
  String borderListString;

  //TODO :: Store Language and Borders is separate db table
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
}

List<Country> countryFromJson(var responseJson) {
  return responseJson.map<Country>((x) => Country.fromJson(x)).toList();
}
