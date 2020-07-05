import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String image;
  final String name;
  final String screen;
  final String screen_product;
  final String screen_res;
  final String system;
  final String cpu;
  final String num_core;
  final String gpu;
  final String memory;
  final String ram;
  final String battery;
  final String camera_main;
  final String camera_feature;
  final String camera_video;
  final String camera_ultra;
  final String camera_tele ;
  final String camera_selef;
  final String camera_selef_feature;
  final String camera_selef_video;
  final String price_eg;
  final String price_sa;
  final String price_uae;
  final String price_jo;
  final String price_sy;
  final String price_alg;
  final String mob_cat;


  Details(
      {this.image,
      this.name,
      this.screen,
      this.screen_product,
      this.screen_res,
      this.system,
      this.cpu,
      this.num_core,
      this.gpu,
      this.memory,
      this.ram,
      this.battery,
      this.camera_main,
      this.camera_feature,
      this.camera_video,
      this.camera_ultra,
      this.camera_tele,
      this.camera_selef,
      this.camera_selef_feature,
      this.camera_selef_video,
      this.price_eg,
      this.price_sa,
      this.price_uae,
      this.price_jo,
      this.price_sy,
      this.price_alg,
      this.mob_cat,
      });

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future getData() async{
    var url = 'http://10.0.2.2:8080/mobtech/index.php';
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('التفاصيل'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .3,
              child: GridTile(
                child: Image.asset(widget.image),
                footer: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .07,
                    color: Colors.black.withOpacity(.3),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "${widget.price_sa}\$",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.name,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "المواصفات",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 _drawBody("الموديل : ", widget.name, Colors.white, Colors.blue),
                  _drawBody("الشاشه : ", widget.screen, Colors.blue, Colors.white),
                  _drawBody("الحمايات : ", widget.screen_product, Colors.white, Colors.blue),
                  _drawBody("دقه الشاشه : ", widget.screen_res, Colors.blue, Colors.white),
                  _drawBody("نظام التشغيل : ", widget.system, Colors.white, Colors.blue),
                  _drawBody("المعالج : ", widget.cpu, Colors.blue, Colors.white),
                  _drawBody("المعالج الرسمي : ", widget.num_core, Colors.white, Colors.blue),
                  _drawBody("البروسيسور : ", widget.gpu, Colors.blue, Colors.white),
                  _drawBody("الذاكره : ", widget.memory, Colors.white, Colors.blue),
                  _drawBody("الرامات : ", widget.ram, Colors.blue, Colors.white),
                  _drawBody("البطاريه : ", widget.battery, Colors.white, Colors.blue),
                  _drawBody("الكاميرا الاسياسيه : ", widget.camera_main, Colors.blue, Colors.white),
                  _drawBody("ميزه الكاميرا : ", widget.camera_feature, Colors.white, Colors.blue),
                  _drawBody("الكاميرا الفيديو : ", widget.camera_video, Colors.blue, Colors.white),
                  _drawBody("الكاميرا الترا : ", widget.camera_ultra, Colors.white, Colors.blue),
                  _drawBody("الكاميرا الفيديو : ", widget.camera_tele, Colors.blue, Colors.white),
                  _drawBody("الكاميرا الاماميه : ", widget.camera_selef, Colors.white, Colors.blue),
                  _drawBody("ميزه الكاميرا الاماميه : ", widget.camera_selef_feature, Colors.blue, Colors.white),
                  _drawBody("الكاميرا الفيديو الاماميه : ", widget.camera_selef_video, Colors.white, Colors.blue),
                  _drawBody("السعر بالمصري : ", widget.price_eg, Colors.blue, Colors.white),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _drawBody(String feature,String details,Color colorBackground,Color colorText){
  return  Container(
      width: double.infinity,
      alignment: Alignment.topRight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: colorBackground
      ),
      child: RichText(
        text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: feature,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w400)
              ),
              TextSpan(
                  text: details,style: TextStyle(fontSize: 18,color: colorText)
              )
            ]
        ),
      )
  );
  }
}
