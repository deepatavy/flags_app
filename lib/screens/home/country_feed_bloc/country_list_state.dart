import 'package:equatable/equatable.dart';
import 'package:flags_app/screens/home/model/country_model.dart';

abstract class CountryListState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends CountryListState {}

class LoadingCountryListFromServer extends CountryListState {}

class CountryListLoaded extends CountryListState {
  final List<Country> countryList;
  CountryListLoaded({required this.countryList});
}

class ErrorLoadingCountries extends CountryListState {
  final error;
  ErrorLoadingCountries({this.error});
}
