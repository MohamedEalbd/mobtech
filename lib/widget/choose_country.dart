import 'package:mobtech/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChooseCountry extends StatefulWidget {
  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  // ignore: missing_return
  Future<String> savePref(String country) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("country", country);
    print(sharedPreferences.getString("country"));
  }
  getPref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String country = sharedPreferences.getString("country");
    if(country != null){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("اختر البلد الموجود فيها"),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              _drawBody("مصر", "assets/images/egypt.png"),
              Divider(),
              _drawBody("السعوديه", "assets/images/saudi.jpg"),
              Divider(),
              _drawBody("سوريا", "assets/images/ayria.jpg"),
              Divider(),
              _drawBody("الجزائر", "assets/images/algeria.jpg"),
              Divider(),
              _drawBody("الامارات", "assets/images/emirate.jpg"),
              Divider(),
              _drawBody("الاردان", "assets/images/Jordan.png")
            ],
          ),
        ),
      ),
    );
  }
  Widget _drawBody(String name,String img){
    return ListTile(
      trailing: CircleAvatar(
        radius: 25,
        backgroundImage:AssetImage(img) ,
      ),
      title: Text(name),
      onTap: () {
        switch(name){
          case "السعوديه":
            savePref("Sadui");
            break;
          case "مصر":
            savePref("Egypt");
            break;
          case "سوريا":
            savePref("Syria");
            break;
          case "الامارات":
            savePref("Emirate");
            break;
          case "الجزائر":
            savePref("Algeria");
            break;
          case "الاردان" :
            savePref("Jordan");
            break;
        }
//        if(name == "السعوديه") {
//          savePref("Sadui");
//        }
//        if(name == "مصر"){
//          savePref("Egypt");
//        }
//        if(name == "سوريا"){
//          savePref("Syria");
//        }
//        if(name == "الامارات"){
//          savePref("Emirate");
//        }
//        if(name == "الجزائر"){
//          savePref("Algeria");
//        }
//        if(name == "الاردان"){
//          savePref("Jordan");
//        }

      },
    );

  }
}
