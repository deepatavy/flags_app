import 'package:equatable/equatable.dart';
import 'package:flags_app/screens/home/model/country_model.dart';

abstract class CountryListState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends CountryListState {}

class LoadingData extends CountryListState {}

class CountryListForRegionLoaded extends CountryListState {
  final List<Country> countryList;
  CountryListForRegionLoaded({required this.countryList});
}

class RegionListLoaded extends CountryListState {
  final List<String> regionList;

  RegionListLoaded({required this.regionList});
}

class ErrorLoadingCountries extends CountryListState {
  final error;

  ErrorLoadingCountries({this.error});
}
