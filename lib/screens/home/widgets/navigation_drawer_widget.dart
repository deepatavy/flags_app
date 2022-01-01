import 'package:flags_app/commons/asset_items.dart';
import 'package:flags_app/screens/home/home_screen.dart';
import 'package:flags_app/screens/home/widgets/exit_alert_widget.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Image.asset(
            imgLogoPath,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home_filled),
            onTap: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => HomeScreen(),
                ),
                (route) => false,
              );
            },
          ),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              showExitAlertDialog(context,fromDrawer: true);
            },
          ),
        ],
      ),
    );
  }
}
