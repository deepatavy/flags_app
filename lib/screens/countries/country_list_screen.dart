import 'package:flags_app/commons/asset_items.dart';
import 'package:flags_app/screens/home/country_temp_screen.dart';
import 'package:flags_app/screens/home/widgets/navigation_drawer_widget.dart';
import 'package:flags_app/screens/neighbours/neighbour_country_list_screen.dart';
import 'package:flutter/material.dart';

class CountryListScreen extends StatefulWidget {
  final String region;

  const CountryListScreen({required this.region});

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  List<String> countryList = ["Afghanistan", "India", "USA", "UK"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.region),
        centerTitle: true,
      ),
      drawer: NavigationDrawerWidget(),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(countryList[index]),
            dense: false,
            tileColor: Colors.white,
            subtitle: Text("capital $index"),
            leading: Image.asset(
              imgLogoPath,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
            style: ListTileStyle.list,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CountryListTempScreen()/*NeighbourCountryListScreen(
                          region: countryList[index],
                        )*/
                ),
              );
            },
          ),
        ),
        itemCount: countryList.length,
      ),
    );
  }
}
