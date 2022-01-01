import 'package:cached_network_image/cached_network_image.dart';
import 'package:flags_app/screens/home/model/country_model.dart';
import 'package:flags_app/screens/neighbours/neighbour_country_list_screen.dart';
import 'package:flutter/material.dart';

class CountryListWidget extends StatelessWidget {
  final List<Country> countryList;

  const CountryListWidget({required this.countryList});

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
            subtitle: Text(countryList[index].capital),
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
            trailing: Icon(Icons.arrow_forward_ios),
            style: ListTileStyle.list,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NeighbourCountryListScreen(
                          countryId: countryList[index].id,
                          countryName: countryList[index].name,
                        )),
              );
            },
          ),
        ),
      ),
      itemCount: countryList.length,
    );
  }
}
