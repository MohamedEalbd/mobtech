import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobtech/model/mobiles_model.dart';
class MobileApi{
  List listSearch = [];
  Future  getData() async{
    var url = "http://10.0.2.2/PHP_Course/index.php";
    var data = {"cat" : "1"};
    var response = await http.post(url,body: data);
    var body = jsonDecode(response.body);
    print(body);
    return body;

    return  body;
  }
  Future  getDataXiaomi() async{
    var url = "http://10.0.2.2/PHP_Course/index.php";
    var data = {"cat" : "2"};
    var response = await http.post(url,body: data);
    var body = jsonDecode(response.body);
    print(body);
    return body;

    return  body;
  }


  Future  getDataHuawei() async{
    var url = "http://10.0.2.2/PHP_Course/index.php";
    var data = {"cat" : "3"};
    var response = await http.post(url,body: data);
    var body = jsonDecode(response.body);
    print(body);
    return body;

    return  body;
  }
  Future getSearch()async{
    var url = "http://10.0.2.2/PHP_Course/search.php";
    var responce = await http.get(url);
    var body = jsonDecode(responce.body);
    for(int i = 0; i<body.length;i++){
     listSearch.add(body[i]['name']);
    }
    print(listSearch);
  }
  Future  getPost() async{
    var url = "http://10.0.2.2/PHP_Course/post.php";
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    print(body);
    return body;
  }



}