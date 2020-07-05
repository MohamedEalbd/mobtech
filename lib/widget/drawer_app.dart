import 'package:flutter/material.dart';
import 'package:mobtech/screens/catagories.dart';
import 'package:mobtech/screens/home.dart';
import 'package:mobtech/screens/login.dart';
import 'package:mobtech/screens/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerApp extends StatefulWidget {
  @override
  _DrawerAppState createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  var username;
  var email;
  bool isSignIn = false;

   @override
  void initState() {
    // TODO: implement initState
     getPref();
    super.initState();
  }
  getPref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username');
    email = sharedPreferences.getString('email');
    if(username != null){
      setState(() {
        username = sharedPreferences.getString('username');
        email = sharedPreferences.getString('email');
        isSignIn = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return  Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.red[900]),
            accountName: isSignIn ? Text(username):Text(""),
            accountEmail: isSignIn ? Text(email):Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/mohamed.jpg'),
            ),
          ),
          ListTile(
            title: Text(
              "الصفحه الرئيسيه",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            leading: Icon(
              Icons.home,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home())),
          ),
          ListTile(
            title: Text(
              "الأقسام",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            leading: Icon(
              Icons.category,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Categories())),
          ),
          isSignIn ? ListTile(
            title: Text(
              "اضافه منشور",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => Post())),
          ):Container(),
          Divider(
            thickness: .5,
          ),
          ListTile(
            title: Text(
              "حول التطبيق",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            leading: Icon(
              Icons.info,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "الأعدادات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {},
          ),

         isSignIn ? ListTile(
           title: Text(
             "تسجيل الخروج",
             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
           ),
           leading: Icon(
             Icons.exit_to_app,
             color: Colors.blue,
             size: 25,
           ),
           onTap: ()  async {
             SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
             sharedPreferences.remove("username");
             sharedPreferences.remove("email");
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogIn()));
    }
         ): ListTile(
            title: Text(
            "تسجيل الدخول",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LogIn())),
          )
        ],
      ),
    );
  }
}
