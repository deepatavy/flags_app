import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountryListEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBorderCountries extends CountryListEvents {
  final String countryId;

  FetchBorderCountries(this.countryId);
}

class FetchAllCountriesForRegion extends CountryListEvents {
  final String region;

  FetchAllCountriesForRegion(this.region);
}

class FetchRegions extends CountryListEvents {}
