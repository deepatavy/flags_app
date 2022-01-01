import 'dart:convert';
import 'package:flags_app/commons/constants.dart';
import 'package:flags_app/screens/home/model/country_model.dart';
import 'package:http/http.dart' as http;

abstract class CountryListRepository {
  Future<List<Country>> getCountryList();
}

class CountryServices implements CountryListRepository {
  @override
  Future<List<Country>> getCountryList() async {
    http.Response response = await http.get(Uri.parse(Constants.API_URL));
    var responseJson = json.decode(response.body);
    return countryFromJson(responseJson);
  }
}
