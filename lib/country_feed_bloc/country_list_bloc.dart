import 'dart:io';

import 'package:flags_app/api/services.dart';
import 'package:flags_app/commons/constants.dart';
import 'package:flags_app/db/country_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flags_app/commons/exceptions.dart';
import 'package:flags_app/screens/home/model/country_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class CountryListBloc extends Bloc<CountryListEvents, CountryListState> {
  final CountryListRepository? countryRepo;

  CountryListBloc({this.countryRepo}) : super(Empty());

  @override
  Stream<CountryListState> mapEventToState(CountryListEvents event) async* {
    if (event is FetchRegions) {
      yield LoadingData();
      try {
        List<String> regionList = [];
        List<Country> countryList = [];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool isDataLoaded = prefs.getBool(Constants.KEY_DATA_LOADED) ?? false;
        if (!isDataLoaded) {
          countryList = await countryRepo!.getCountryList();
          CountryDatabase.instance.insertAllCountries(countryList);
        }
        regionList = await CountryDatabase.instance.getAllRegions();
        yield RegionListLoaded(regionList: regionList);
      } on SocketException {
        yield ErrorLoadingCountries(
          error: NoInternetException('No Internet'),
        );
      } on HttpException {
        yield ErrorLoadingCountries(
          error: NoServiceFoundException('No Service Found'),
        );
      } on FormatException {
        yield ErrorLoadingCountries(
          error: InvalidFormatException('Invalid Response format'),
        );
      } catch (e) {
        yield ErrorLoadingCountries(
          error: UnknownException('Unknown Error'),
        );
      }
    }
    if (event is FetchAllCountriesForRegion) {
      yield LoadingData();
      List<Country> countryList = await CountryDatabase.instance.getCountriesForRegion(event.region);
      yield CountryListForRegionLoaded(countryList: countryList);
    }
    if (event is FetchBorderCountries) {
      yield LoadingData();
      List<Country> countryList = await CountryDatabase.instance.getBorderCountries(event.countryId);
      yield CountryListForBordersLoaded(countryList: countryList);
    }
  }
}
