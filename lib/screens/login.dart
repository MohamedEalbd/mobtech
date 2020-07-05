import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:mobtech/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              Text("Loading...."),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

showdialogAll(context, String myTitle, String myContent) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(myTitle),
          content: Text(myContent),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text("done")),
          ],
        );
      });
}

class _LogInState extends State<LogIn> {
  final _formKeySignUp = GlobalKey<FormState>();
  final _formKeySignIn = GlobalKey<FormState>();
  TextEditingController _confirmPassController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passLoginController = TextEditingController();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  bool showen = true;
  bool showenPass = true;
  bool confirmPass = true;
  bool showSigin = true;
  bool isLoading = false;
  TapGestureRecognizer _changeSign;

  Future<String> savePref(String username, String email,String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("id", id);
    sharedPreferences.setString("username", username);
    sharedPreferences.setString("email", email);
    print(sharedPreferences.getString("username"));
    print(sharedPreferences.getString("email"));
    print(sharedPreferences.getString("id"));
  }

  signIn() async {
    var formdata = _formKeySignIn.currentState;
    if (formdata.validate()) {
      formdata.save();
      showLoading(context);
      var data = {
        "email": email.text,
        "password": passLoginController.text,
      };
      var url = "http://10.0.2.2/PHP_Course/login.php";
      var response = await http.post(url, body: data);
      var body = jsonDecode(response.body);
      if (body['status'] == 'success') {
        //     print(body['username']);
        savePref(body['username'], body['email'],body['id']);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      } else {
        print("Loading failed");
        showdialogAll(
            context, "خطا", "البريد الالكتروني أو كلمه المرور خاطئه ");
      }
    }
  }

  signUp() async {
    var formdata = _formKeySignUp.currentState;
    if (formdata.validate()) {
      formdata.save();
      showLoading(context);
      var data = {
        "email": email.text,
        "password": passController.text,
        "username": usernameController.text
      };
      var url = "http://10.0.2.2/PHP_Course/signup.php";
      var response = await http.post(url, body: data);
      var body = jsonDecode(response.body);
      if (body['status'] == 'success') {
        print('success');
        savePref(body['username'], body['email'],body['id']);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      } else {
        print(body['status']);
        Navigator.of(context).pop();
        showdialogAll(context, "خطا", "البريد الالكتروني موجود سابقا");
      }
      print("Vaild");
    } else {
      print("UnVaild");
    }
  }

  String validUsername(String val) {
    if (val.isEmpty) {
      return "لا يمكن ان يكون اسم المستخدم فارغ";
    }
    if (val.trim().length < 4) {
      return "لا يمكن ان يكون اسم المستخدم اقل من 4 احرف";
    }
    if (val.trim().length > 20) {
      return "لا يمكن ان يكون اسم المستخدم اكبر من 20 احرف";
    }
  }

  String validEmail(String val) {
    if (val.isEmpty) {
      return "لا يمكن ان يكون الايميل فارغ";
    }
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(val)) {
      return "عنوان البريد غير صحيح يجب ان يكون علي سبيل المثال مثل (example@gmail.com  )";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _changeSign = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showSigin = !showSigin;
        });
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          buildPositionedTop(width),
          buildPositionedButtom(width),
          Container(
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      showSigin ? "تسجيل الدخول" : "انشاء حساب",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: showSigin ? 22 : 10)),
                buildContainerAvater(width),
                showSigin
                    ? buildContainerFormSignIn(context, width)
                    : buildContainerFormSignUp(context, width),
                buildContainerButtomForm(),
              ],
            )),
          ),
        ],
      )),
    );
  }

  Container buildContainerButtomForm() {
    return Container(
      margin: EdgeInsets.only(
        top: showSigin ? 20 : 8,
      ),
      padding: EdgeInsets.only(bottom: showSigin ? 0 : 8),
      child: Column(
        children: <Widget>[
          showSigin
              ? InkWell(
                  onTap: () {},
                  child: Text(
                    "هل نسيت كلمه المرور ؟",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ))
              : SizedBox(),
          SizedBox(
            height: showSigin ? 10 : 10,
          ),
          RaisedButton(
            color: showSigin ? Colors.blue : Colors.grey[700],
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            onPressed: showSigin ? signIn : signUp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  showSigin ? "تسجيل الدخول" : "انشاء حساب",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    margin: EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: showSigin
                        ? "في حال ليس لديك حساب يمكنك؟ "
                        : "اذا كان لديك حساب يمكنك ",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                TextSpan(
                    recognizer: _changeSign,
                    text:
                        showSigin ? "انشاء حساب من هنا" : "تسجيل دخول من هنا ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                        decorationStyle: TextDecorationStyle.solid))
              ]),
            ),
          ),
         showSigin?  Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                        color: Colors.blue,
                      onPressed: () {},
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset("assets/images/google.png",width: 33,height: 35),
                        SizedBox(width: 10,),
                        Text("Sign in Google",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 16),),
                      ],
                    ),
                  )),
                  SizedBox(width: 5,),
                  Expanded(
                      child: RaisedButton(
                        color: Colors.red[900],
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset("assets/images/facebook.png",width: 33,height: 35,),
                            SizedBox(width: 8,),
                            Text("Sign in facebook",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 16),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ):Container()
        ],
      ),
    );
  }

  buildContainerFormSignIn(BuildContext context, double width) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInBack,
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * .35,
        width: width * .85,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: .1,
              blurRadius: 2,
              offset: Offset(1, 1))
        ]),
        child: Form(
            key: _formKeySignIn,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "البريد الالكتروني ",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildTextFormFieldName(
                        "ادخل البريد الالكتروني هنا", email, validEmail),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "كلمه المرور",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: passLoginController,
                      validator: (val) {
                        if (val.trim().isEmpty) {
                          return "ادخل من فضلك كلمه المرور";
                        }
                        if (val.trim().length < 4) {
                          return "لا يمكن ان يكون كلمه المرور اقل من 4 احرف";
                        }
                        if (val.trim().length > 20) {
                          return "لا يمكن ان يكون كلمه المرور اقل من 20 حرف";
                        }
                      },
                      obscureText: showen,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "ادخل كلمه المرور هنا ",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[500],
                                style: BorderStyle.solid,
                                width: 1),
                          ),
                          suffixIcon: IconButton(
                              icon: showen
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.panorama_fish_eye),
                              onPressed: () {
                                setState(() {
                                  if (showen == true) {
                                    showen = false;
                                  } else if (showen == false) {
                                    showen = true;
                                  }
                                });
                              })),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  AnimatedContainer buildContainerAvater(double width) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: MediaQuery.of(context).size.height * .15,
        width: width * .25,
        decoration: BoxDecoration(
            color: showSigin ? Colors.blue : Colors.grey[700],
            borderRadius: BorderRadius.circular(width),
            boxShadow: [
              showSigin
                  ? BoxShadow(
                      color: Colors.black, blurRadius: 5, spreadRadius: 2.1)
                  : BoxShadow(
                      color: Colors.white, blurRadius: 3, spreadRadius: 2.1)
            ]),
        child: InkWell(
          onTap: () {
            setState(() {
              showSigin = !showSigin;
            });
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 25,
                  right: 25,
                  child: showSigin
                      ? Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.person_outline,
                          size: 50,
                          color: Colors.white,
                        )),
              Positioned(
                top: 37,
                right: 15,
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }

  Positioned buildPositionedTop(double width) {
    return Positioned(
      child: Transform.scale(
        scale: 1.3,
        child: Transform.translate(
          offset: Offset(0, -width / 1.7),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: width,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width),
                color: showSigin
                    ? Colors.grey[800]
                    : Colors.deepPurple.withOpacity(.8)),
          ),
        ),
      ),
    );
  }

  Positioned buildPositionedButtom(double width) {
    return Positioned(
      top: MediaQuery.of(context).size.height * .2,
      right: width / 1.3,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: width,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width),
            color: showSigin
                ? Colors.blue[800].withOpacity(.5)
                : Colors.grey[800].withOpacity(.4)),
      ),
    );
  }

  buildContainerFormSignUp(BuildContext context, double width) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeIn,
        margin: EdgeInsets.only(top: 7),
        height: MediaQuery.of(context).size.height * .56,
        width: width * .85,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: .1,
              blurRadius: 2,
              offset: Offset(1, 1))
        ]),
        child: Form(
            key: _formKeySignUp,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "اسم المستخدم",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFormFieldName("ادخل اسم المستخدم هنا ",
                        usernameController, validUsername),
                    Text(
                      "الأيميل",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFormFieldName(
                        "ادخل البريد الالكتروني ", email, validEmail),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "كلمه المرور",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: showenPass,
                      validator: (val) {
                        if (val.trim().isEmpty) {
                          return "ادخل من فضلك كلمه المرور";
                        }
                        if (val.trim().length < 4) {
                          return "لا يمكن ان يكون كلمه المرور اقل من 4 احرف";
                        }
                        if (val.trim().length > 20) {
                          return "لا يمكن ان يكون كلمه المرور اقل من 20 حرف";
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "ادخل كلمه المرور هنا ",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[500],
                                style: BorderStyle.solid,
                                width: 1),
                          ),
                          suffixIcon: IconButton(
                              icon: showenPass
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.panorama_fish_eye),
                              onPressed: () {
                                setState(() {
                                  if (showenPass == true) {
                                    showenPass = false;
                                  } else if (showenPass == false) {
                                    showenPass = true;
                                  }
                                });
                              })),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "تاكيد كلمه المرور",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _confirmPassController,
                      obscureText: confirmPass,
                      validator: (val) {
                        if (val.trim().isEmpty) {
                          return "ادخل من فضلك كلمه المرور";
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "ادخل كلمه المرور هنا مره اخري ",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[500],
                                style: BorderStyle.solid,
                                width: 1),
                          ),
                          suffixIcon: IconButton(
                              icon: confirmPass
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.panorama_fish_eye),
                              onPressed: () {
                                setState(() {
                                  if (confirmPass == true) {
                                    confirmPass = false;
                                  } else if (confirmPass == false) {
                                    confirmPass = true;
                                  }
                                });
                              })),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  TextFormField buildTextFormFieldName(
      String txt, TextEditingController myController, Function myValid) {
    return TextFormField(
      controller: myController,
      validator: myValid,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.grey[200],
          hintText: txt,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey[500], style: BorderStyle.solid, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue[500], style: BorderStyle.solid, width: 1),
          )),
    );
  }
}
