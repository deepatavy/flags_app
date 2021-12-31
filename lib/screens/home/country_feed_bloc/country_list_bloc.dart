import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flags_app/commons/exceptions.dart';
import 'package:flags_app/screens/home/api/services.dart';
import 'package:flags_app/screens/home/country_feed_bloc/country_list_event.dart';
import 'package:flags_app/screens/home/country_feed_bloc/country_list_state.dart';
import 'package:flags_app/screens/home/model/country_model.dart';

class CountryListBloc extends Bloc<CountryListEvents, CountryListState> {
  final CountryListRepository countryRepo;

  CountryListBloc({required this.countryRepo}) : super(Empty());

  @override
  Stream<CountryListState> mapEventToState(CountryListEvents event) async* {
    switch (event) {
      case CountryListEvents.fetchCountries:
        yield LoadingCountryListFromServer();
        try {
          List<Country> countryList = [];
          countryList = await countryRepo.getCountryList();
          yield CountryListLoaded(countryList: countryList);
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
        break;
    }
  }
}
