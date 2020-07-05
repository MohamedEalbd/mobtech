import 'package:flutter/material.dart';
import 'package:mobtech/screens/details.dart';

class MobList extends StatelessWidget {
  var price;
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
  final String camera_tele;
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
  final String img;
  final String country;
  MobList(
      {this.name,
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
      this.img,
      this.country});

  @override
  Widget build(BuildContext context) {
    if(country == 'Egypt'){
      price = price_eg;
    }
    if(country == 'Sadui'){
      price = price_sa;
    }
    if(country == 'Syria'){
      price = price_sy;
    }
    if(country == 'Emirate'){
      price = price_uae;
    }
    if(country == 'Algeria'){
      price = price_alg;
    }
    if(country == 'Jordan'){
      price = price_jo;
    }


    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Details(
            image: img,
            name: name,
            price_sa: price_sa,
            mob_cat: mob_cat,
            system: system,
            screen_res: screen_res,
            screen_product: screen_product,
            screen: screen,
            num_core: num_core,
            ram: ram,
            gpu: gpu,
            battery: battery,
            camera_feature: camera_feature,
            camera_main: camera_main,
            camera_selef: camera_selef,
            camera_selef_feature: camera_selef_feature,
            camera_selef_video: camera_selef_video,
            cpu: cpu,
            camera_ultra: camera_ultra,
            camera_tele: camera_tele,
            camera_video: camera_video,
            memory: memory,
            price_alg: price_alg,
            price_eg: price_eg,
            price_jo: price_jo,
            price_sy: price_sy,
            price_uae: price_uae,
              ))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          child: Card(
            elevation: 5.0,
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: Image.asset(img)),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Text(
                                  "الكاميرا : ",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  camera_main,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Text(
                                  "المعالج :",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  num_core,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Text(
                                  "الرامات : ",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  ram,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Text(
                                  "الذكره :",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  memory,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )),
                          ],
                        ),
                        Text(
                          "السعر : ${price}",
                          style:
                              TextStyle(color: Colors.red[800], fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
