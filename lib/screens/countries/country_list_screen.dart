import 'package:flags_app/country_feed_bloc/bloc.dart';
import 'package:flags_app/screens/countries/widget/country_list_widget.dart';
import 'package:flags_app/screens/home/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryListScreen extends StatelessWidget {
  final String region;

  const CountryListScreen({required this.region});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryListBloc(),
      child: CountryListBuild(
        region: region,
      ),
    );
  }
}

class CountryListBuild extends StatefulWidget {
  final String region;

  const CountryListBuild({required this.region});

  @override
  _CountryListBuildState createState() => _CountryListBuildState();
}

class _CountryListBuildState extends State<CountryListBuild> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountryListBloc>(context).add(FetchAllCountriesForRegion(widget.region));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.region),
          centerTitle: true,
          actions: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_back_ios),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        drawer: NavigationDrawerWidget(),
        body: BlocBuilder<CountryListBloc, CountryListState>(builder: (BuildContext context, CountryListState state) {
          if (state is ErrorLoadingCountries) {
            final error = state.error;
            return Center(child: Text(error.message));
          }
          if (state is CountryListForRegionLoaded) {
            return CountryListWidget(countryList: state.countryList);
          }
          return Center(child: CircularProgressIndicator());
        }));
  }
}
