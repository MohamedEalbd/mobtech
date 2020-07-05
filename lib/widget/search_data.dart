import 'package:flutter/material.dart';
import 'package:mobtech/api/mobiles_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'moblist.dart';

class DataSearch extends SearchDelegate<String> {
  MobileApi mobileApi = MobileApi();
  List<dynamic> list;
  DataSearch({this.list});
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

  Future getSearchMobile()async{
    var url = "http://10.0.2.2/PHP_Course/searchmob.php";
    var data = {"searchmobile" : query};
    var response = await http.post(url,body: data);
    var body = jsonDecode(response.body);
    print(body);
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: Action for AppBar
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: Icon Leading
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Result search
    return  FutureBuilder(
        future: getSearchMobile(),
        builder: (BuildContext context,AsyncSnapshot snapShot){
          if(snapShot.hasData){
            return ListView.builder(
              itemCount: snapShot.data.length,
              itemBuilder: (context, index) {
                return MobList(
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: show when someone searchs for something
    var searchList =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.mobile_screen_share),
            title: Text(searchList[index]),
            trailing: IconButton(icon: Icon(Icons.clear), onPressed: () {}),
            onTap: (){
              query = searchList[index];
              showResults(context);
            },
          );
        });
  }
}
