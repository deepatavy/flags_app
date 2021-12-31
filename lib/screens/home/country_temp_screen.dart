import 'package:flags_app/screens/home/api/services.dart';
import 'package:flags_app/screens/home/country_feed_bloc/bloc.dart';
import 'package:flags_app/screens/home/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryListTempScreen extends StatelessWidget {
  const CountryListTempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryListBloc(countryRepo: CountryServices()),
      child: CountryScreen(),
    );
  }
}

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountryListBloc>(context).add(CountryListEvents.fetchCountries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        title: Text('Countries'),
      ),
      body: Column(
        children: [
          BlocBuilder<CountryListBloc, CountryListState>(builder: (BuildContext context, CountryListState state) {
            if (state is ErrorLoadingCountries) {
              final error = state.error;
              return Center(child: Text(error.message));
            }
            if (state is CountryListLoaded) {
              return _list(state.countryList);
            }
            return Center(child: CircularProgressIndicator());
          }),
        ],
      ),
    );
  }

  Widget _list(List<Country> countries) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: Text(countries[index].name),
          ),
        );
      },
    );
  }
}
