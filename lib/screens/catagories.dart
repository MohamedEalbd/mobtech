import 'package:flutter/material.dart';
import 'package:mobtech/screens/samsung.dart';
import 'package:mobtech/screens/realme.dart';
import 'package:mobtech/widget/drawer_app.dart';

import 'huawei.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الاقسام'),
          centerTitle: true,
        ),
        drawer: DrawerApp(),
        body: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: <Widget>[
            Container(
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Samsung())),
                  child: Card(
              child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Image.asset(
                      'assets/images/logo_sam.png',
                      fit: BoxFit.cover,
                    )),
                    Container(
                      padding: EdgeInsets.only(top: 8,bottom: 5),
                      child: Text(
                        'Samsung',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                  ],
              ),
            ),
                )),
            InkWell(
              onTap: () {},
              child: Container(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset(
                              'assets/images/xiaomi_logo.jpg',
                              fit: BoxFit.cover,
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 8,bottom: 5),
                          child: Text(
                            'Xiaomi',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                      ],
                    ),
                  )),
            ),
            Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Image.asset(
                            'assets/images/oppo_logo.jpg',
                            fit: BoxFit.cover,
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 8,bottom: 5),
                        child: Text(
                          'OPPO',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Huawei())),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset(
                              'assets/images/huawei.png',
                              fit: BoxFit.cover,
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 8,bottom: 5),
                          child: Text(
                            'Huawei',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Realme())),
              child: Container(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset(
                              'assets/images/realme_logo.jpg',
                              fit: BoxFit.cover,
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 8,bottom: 5),
                          child: Text(
                            'Realme',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Image.asset(
                            'assets/images/apple_logo.jpg',
                            fit: BoxFit.cover,
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 8,bottom: 5),
                        child: Text(
                          'Apple',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),


          ],
        ),
      ),
    );
  }
}
