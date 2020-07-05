import 'package:flutter/material.dart';
import 'package:mobtech/screens/home.dart';
import 'package:mobtech/widget/choose_country.dart';

import 'api/mobiles_api.dart';

void main() {
  MobileApi api = MobileApi();
  //api.getData();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, theme:ThemeData(fontFamily: 'Cairo'),home: Myapp()));
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}
class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ChooseCountry(),
      ),
    );
  }
}
