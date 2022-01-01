import 'package:flags_app/screens/home/model/country_model.dart';
import 'package:flutter/material.dart';

class NeighbourCountryListWidget extends StatelessWidget {
  final List<Country> countryList;

  const NeighbourCountryListWidget({required this.countryList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: ListTile(
            title: Text(countryList[index].name),
            dense: false,
            tileColor: Colors.white,
            subtitle: Text(countryList[index].languages!.values.toString()),
            leading: Image.network(
              countryList[index].flagUrl,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
            style: ListTileStyle.list,
          ),
        ),
      ),
      itemCount: countryList.length,
    );
  }
}
