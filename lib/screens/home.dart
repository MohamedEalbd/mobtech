import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobtech/api/mobiles_api.dart';
import 'package:mobtech/widget/carousel_app.dart';
import 'package:mobtech/widget/drawer_app.dart';
import 'package:mobtech/widget/search_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MobileApi mobileApi = MobileApi();
  String country ;
  getPref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     country = sharedPreferences.getString("country");
    print(country);
  }
  @override
  void initState() {
    // TODO: implement initState
    mobileApi.getSearch();
    getPref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mobtech'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {
//              return showDialog(context: context,builder: (context){
//                return AlertDialog(
//                  title: Text("search"),
//                  content: Container(
//                    height: MediaQuery.of(context).size.height * .15,
//                    child: Column(
//                      children: <Widget>[
//                        Text("ادخل اسم الجوال الذي تريد البحث عنه"),
//                        TextFormField(
//                          textAlign: TextAlign.right,
//                          decoration: InputDecoration(
//                            hintText: "اكتب هنا"
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  actions: <Widget>[
//                    FlatButton(onPressed: (){}, child: Text("تم")),
//                    FlatButton(onPressed: ()=>Navigator.pop(context), child: Text("الغاء")),
//                  ],
//                );
//              });
              showSearch(context: context, delegate: DataSearch(list: mobileApi.listSearch));
            })
          ],
        ),
        drawer: DrawerApp(),
        body: ListView(
          children: <Widget>[
            CarouserlApp(),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: Text(
                'الأقسام',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            _drawCate(),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(10),
              child: Text(
                'اخر المنتجات',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            _drawViewProduct(),
          ],
        ),
      ),
    );
  }

  Widget _drawCate() {
    return Container(
      height: MediaQuery.of(context).size.height * .19,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .29,
            child: ListTile(
              title: Image.asset(
                "assets/images/sams.png",
                fit: BoxFit.fill,
                height: 90,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Samsung',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .29,
            child: ListTile(
              title: Image.asset(
                "assets/images/Huawei-Logo.jpg",
                fit: BoxFit.fill,
                height: 90,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Huawei',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .29,
            child: ListTile(
              title: Image.asset(
                "assets/images/oppo.png",
                fit: BoxFit.fill,
                height: 90,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'OPPO',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .29,
            child: ListTile(
              title: Image.asset("assets/images/Realme.jpg",
                  height: 90, fit: BoxFit.fill),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Realme',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawViewProduct() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * .4,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: GridTile(
                child: Image.asset('assets/product/pro.jpg'),
                footer: Container(
                  margin: EdgeInsets.all(8),
                  height: 20,
                  color: Colors.black.withOpacity(.4),
                  child: Text(
                    'P30 PRO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: GridTile(
                child: Image.asset('assets/product/opp.png'),
                footer: Container(
                  margin: EdgeInsets.all(8),
                  height: 20,
                  color: Colors.black.withOpacity(.4),
                  child: Text(
                    'P30 PRO',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: GridTile(
                child: Image.asset(
                  'assets/product/rea.png',
                ),
                footer: Container(
                  margin: EdgeInsets.all(8),
                  height: 20,
                  color: Colors.black.withOpacity(.4),
                  child: Text(
                    'P30 PRO',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){},
              child: GridTile(
                child: Image.asset('assets/product/pro.jpg'),
                footer: Container(
                  margin: EdgeInsets.all(8),
                  height: 20,
                  color: Colors.black.withOpacity(.4),
                  child: Text(
                    'P30 PRO',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
