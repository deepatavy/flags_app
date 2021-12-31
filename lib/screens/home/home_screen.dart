import 'package:flags_app/screens/countries/country_list_screen.dart';
import 'package:flags_app/screens/home/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> regionList = ["Asia", "Africa", "Europe", "Middle East"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      drawer: NavigationDrawerWidget(),
      body: ListView.builder(
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
      ),
    );
  }
}
