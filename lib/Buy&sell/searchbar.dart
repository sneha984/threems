import 'package:flutter/material.dart';

class SearchBarPage extends StatefulWidget {
  final String shopname;
  const SearchBarPage({Key? key, required this.shopname}) : super(key: key);

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  String name="";
  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(


    );
  }
}
