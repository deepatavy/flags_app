import 'package:flags_app/screens/home/api/services.dart';
import 'package:flags_app/screens/home/widgets/navigation_drawer_widget.dart';
import 'package:flags_app/screens/home/widgets/region_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'country_feed_bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryListBloc(countryRepo: CountryServices()),
      child: HomeScreenBuild(),
    );
  }
}

class HomeScreenBuild extends StatefulWidget {
  const HomeScreenBuild({Key? key}) : super(key: key);

  @override
  State<HomeScreenBuild> createState() => _HomeScreenBuildState();
}

class _HomeScreenBuildState extends State<HomeScreenBuild> {
  late bool isDataLoaded;
  late bool isLoading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountryListBloc>(context).add(FetchRegions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      drawer: NavigationDrawerWidget(),
      body: BlocBuilder<CountryListBloc, CountryListState>(builder: (BuildContext context, CountryListState state) {
        if (state is ErrorLoadingCountries) {
          final error = state.error;
          return Center(child: Text(error.message));
        }
        if (state is RegionListLoaded) {
          return RegionListWidget(regionList: state.regionList);
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
