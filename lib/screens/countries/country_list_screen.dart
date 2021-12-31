import 'package:flutter/material.dart';

class CountryListScreen extends StatefulWidget {
  final String region;

  const CountryListScreen({required this.region});

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.region),
        centerTitle: true,
      ),
    );
  }
}
