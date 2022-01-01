import 'package:cached_network_image/cached_network_image.dart';
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
            subtitle:
                Text(countryList[index].languages!.isNotEmpty ? countryList[index].languages!.values.toString() : ''),
            leading: CachedNetworkImage(
              imageUrl: countryList[index].flagUrl,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 60,
                  color: Colors.red.withAlpha(80),
                  child: Text(
                    countryList[index].name[0],
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
              placeholder: (_, __) => Container(
                alignment: Alignment.center,
                height: 60,
                width: 60,
                color: Colors.red.withAlpha(80),
                child: Text(
                  countryList[index].name[0],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            style: ListTileStyle.list,
          ),
        ),
      ),
      itemCount: countryList.length,
    );
  }
}
