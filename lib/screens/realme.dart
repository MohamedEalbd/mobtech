import 'package:flutter/material.dart';
import 'package:mobtech/api/mobiles_api.dart';
import 'package:mobtech/widget/moblist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Realme extends StatefulWidget {
  @override
  _RealmeState createState() => _RealmeState();
}

class _RealmeState extends State<Realme> {
  MobileApi mobileApi = MobileApi();
  var mobileList = [
    {
      'image' : "assets/product/rea.png",
    },
    {
      'image' : "assets/product/pro.jpg",
    },
    {
      'image' : "assets/product/opp.png",
    },
  ];
  String country;
  getPref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      country = sharedPreferences.getString("country");
    });
    print(country);
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
              title: Text("شاومي"),
              centerTitle: true,
            ),
            body: FutureBuilder(
                future: mobileApi.getDataXiaomi(),
                builder: (BuildContext context,AsyncSnapshot snapShot){
                  if(snapShot.hasData){
                    return ListView.builder(
                      itemCount: snapShot.data.length,
                      itemBuilder: (context, index) {
                        return MobList(
                          country: country,
                          img: mobileList[index]['image'],
                          name: snapShot.data[index]['name'],
                          gpu: snapShot.data[index]['gpu'],
                          camera_main: snapShot.data[index]['camera_main'],
                          camera_feature: snapShot.data[index]['camera_feature'],
                          camera_selef: snapShot.data[index]['camera_self'],
                          camera_selef_feature: snapShot.data[index]['camera_self_feature'],
                          camera_selef_video: snapShot.data[index]['camera_self_video'],
                          camera_tele: snapShot.data[index]['camera_tele'],
                          camera_ultra: snapShot.data[index]['camera_ultra'],
                          camera_video: snapShot.data[index]['camera_video'],
                          cpu: snapShot.data[index]['cpu'],
                          battery: snapShot.data[index]['battery'],
                          price_eg: snapShot.data[index]['price_eg'],
                          price_jo: snapShot.data[index]['price_jo'],
                          price_alg: snapShot.data[index]['price_alg'],
                          price_sa: snapShot.data[index]['price_sa'],
                          price_sy: snapShot.data[index]['price_sy'],
                          price_uae: snapShot.data[index]['price_uae'],
                          ram: snapShot.data[index]['ram'],
                          num_core: snapShot.data[index]['num_core'],
                          screen: snapShot.data[index]['screen'],
                          screen_product: snapShot.data[index]['screen_protect'],
                          screen_res: snapShot.data[index]['screen_res'],
                          system: snapShot.data[index]['system'],
                          mob_cat: snapShot.data[index]['mob_cat'],
                          memory: snapShot.data[index]['memory'],
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                })
        ));
  }
}
