import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountryListEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllCountriesForRegion extends CountryListEvents {
  final String region;

  FetchAllCountriesForRegion(this.region);

  @override
  List<Object> get props => [region];
}

class FetchRegions extends CountryListEvents {}
