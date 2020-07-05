import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobtech/screens/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comments extends StatefulWidget {
  final String postId;
  Comments({this.postId});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var id ="";
  TextEditingController _commentController = new TextEditingController();

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString("id");
    });
  }
  Future  getComment() async{
    var url = "http://10.0.2.2/PHP_Course/comment.php";
    var  data = {
      "postid" : widget.postId
    };
    var response = await http.post(url,body: data);
    var body = jsonDecode(response.body);
    print(body);
    return body;
  }
  //staring Challenge number 4
  Future  addComment() async{
    var url = "http://10.0.2.2/PHP_Course/addcomment.php";
    var data = {"comment" : _commentController.text,"comuser" : id,'compost':widget.postId};
    var response = await http.post(url,body: data);
    var body = jsonDecode(response.body);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Post()));
    return body;
  }
  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * .089,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey))),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.camera_enhance,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              width: MediaQuery.of(context).size.width * .88,
                              child: TextFormField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                    hintText: "    اكتب تعليقك هنا",
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.send),
                                        onPressed: addComment),
                                    contentPadding: EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 5),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              )),
            Positioned(
                top: 30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height -100 ,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FutureBuilder(
                            future: getComment(),
                            builder: (context,snapShot){
                              if(snapShot.hasData){
                                return Column(
                                  children: <Widget>[
                                    for(int i =0; i< snapShot.data.length;i++)
                                      CommentsList(username: snapShot.data[i]['username'],comment: snapShot.data[i]['comment'],)
                                  ],
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            })

                      ],
                    ),
                  ),
                )),

        ],
      ),
    ));
  }
}
class CommentsList extends StatelessWidget {
  final String postId;
  final String username;
  final String comment;
  CommentsList({this.username,this.comment,this.postId});
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(username)),
      subtitle: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey.withOpacity(.2),
          child: Text(comment)),
    );
  }
}
