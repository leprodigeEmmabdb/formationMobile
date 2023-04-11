import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DemoC extends StatefulWidget {
  const DemoC({Key? key}) : super(key: key);

  @override
  State<DemoC> createState() => _DemoCState();
}

class _DemoCState extends State<DemoC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carousel"),
        backgroundColor: Colors.orange,
      ),
      body: _crousel(),
    );
  }
}

Widget _crousel(){
  List<Widget> imgList = [
    Image.asset('assets/girl.png'),
    Image.asset('assets/girl.png'),
    Image.asset('assets/girl.png'),
  ];
  return CarouselSlider(
    options: CarouselOptions(
        height: 400.0,autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn),
    items:imgList.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(

              ),
              child: Image.asset('assets/gmail.png')
          );
        },
      );
    }).toList(),
  );
}
