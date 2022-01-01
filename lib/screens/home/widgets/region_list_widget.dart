import 'package:flags_app/screens/countries/country_list_screen.dart';
import 'package:flutter/material.dart';

class RegionListWidget extends StatelessWidget {
  final List<String> regionList;

  const RegionListWidget({required this.regionList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text(regionList[index]),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CountryListScreen(
                        region: regionList[index],
                      )),
            );
          },
        ),
      ),
      itemCount: regionList.length,
    );
  }
}
