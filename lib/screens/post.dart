import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobtech/api/mobiles_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  var username = "none";
  String email;
  var id = "";
  MobileApi mobileApi = MobileApi();
  TextEditingController _addPost = new TextEditingController();

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString('id');
      username = sharedPreferences.getString('username');
      email = sharedPreferences.getString('email');
    });
  }
  Future  addPost() async{
    var url = "http://10.0.2.2/PHP_Course/addpost.php";
    var data = {"post" : _addPost.text,"postuser" : id};
    var response = await http.post(url,body: data);
    var body = jsonDecode(response.body);
   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Post()));
    return body;
  }

  @override
  void initState() {
    // TODO: implement initState
    getPref();
    mobileApi.getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("المنشورات"),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: TextFormField(
                        controller: _addPost,
                        maxLength: 300,
                        maxLines: 6,
                        minLines: 1,
                        decoration: InputDecoration(
                            hintText: "اضف جوال للبيع",
                            contentPadding: EdgeInsets.only(right: 10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: InkWell(
                          onTap: addPost,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.2)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "اضف منشور",style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16
                                ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 10,),
                                Icon(Icons.add_box,color: Colors.grey,)
                              ],
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: mobileApi.getPost(),
                  builder: (context,snapShot){
                   if(snapShot.hasData){
                     return Column(
                       children: <Widget>[
                         for( int i = snapShot.data.length-1;i >=0;i--)
                           PostList(
                             username:snapShot.data[i]['username'] ,
                             contentPost: snapShot.data[i]['post'] ,
                             postId: snapShot.data[i]['post_id'],
                           )
                       ],
                     );
                   }
                   return Center(child: CircularProgressIndicator());
              })
            ],
          ),
        ));
  }
}
class PostList extends StatelessWidget {
  final String postId;
  final String username;
  final String contentPost;
  PostList({this.username,this.contentPost,this.postId});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                username,
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w800),
              ),
            ),
            trailing: IconButton(
                icon: Icon(Icons.filter_list), onPressed: () {}),
            subtitle: Text(
                contentPost,
              style: TextStyle(letterSpacing: 1, fontSize: 18),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(.5),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5, bottom: 7),
                    decoration: BoxDecoration(
                        border:
                        Border(left: BorderSide(color: Colors.grey))),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "اعجاب",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.thumb_up,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 7),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Comments(postId:postId))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "تعليق",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.mode_comment,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
