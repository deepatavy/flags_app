import 'package:flags_app/screens/home/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class NeighbourCountryListScreen extends StatefulWidget {
  final String region;

  const NeighbourCountryListScreen({required this.region});

  @override
  _NeighbourCountryListScreenState createState() => _NeighbourCountryListScreenState();
}

class _NeighbourCountryListScreenState extends State<NeighbourCountryListScreen> {
  List<String> countryList = ["Afghanistan", "India", "USA", "UK"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neighbours of " + widget.region),
        centerTitle: true,
      ),
      drawer: NavigationDrawerWidget(),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(countryList[index]),
            leading: Container(
              color: Colors.red,
              width: 5,
            ),
            tileColor: Colors.white,
            subtitle: Text("Languages ${countryList.toString()}"),
            style: ListTileStyle.list,
            onTap: () {},
          ),
        ),
        itemCount: countryList.length,
      ),
    );
  }
}
