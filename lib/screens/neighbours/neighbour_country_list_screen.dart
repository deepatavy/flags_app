import 'package:flags_app/country_feed_bloc/bloc.dart';
import 'package:flags_app/screens/home/widgets/navigation_drawer_widget.dart';
import 'package:flags_app/screens/neighbours/widget/country_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NeighbourCountryListScreen extends StatelessWidget {
  final String countryId;
  final String countryName;

  const NeighbourCountryListScreen({required this.countryId,required this.countryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryListBloc(),
      child: NeighbourCountryListBuild(
        countryId: countryId,
        countryName: countryName,
      ),
    );
  }
}

class NeighbourCountryListBuild extends StatefulWidget {
  final String countryId;
  final String countryName;

  const NeighbourCountryListBuild({required this.countryId,required this.countryName});

  @override
  _NeighbourCountryListBuildState createState() => _NeighbourCountryListBuildState();
}

class _NeighbourCountryListBuildState extends State<NeighbourCountryListBuild> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountryListBloc>(context).add(FetchBorderCountries(widget.countryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.countryName + "'s Neighbours"),
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
          if (state is CountryListForBordersLoaded) {
            return state.countryList.isEmpty
                ? Center(
                    child: Text("No Data Available"),
                  )
                : NeighbourCountryListWidget(countryList: state.countryList);
          }
          return Center(child: CircularProgressIndicator());
        }));
  }
}
