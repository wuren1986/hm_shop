// 轮播图组件
import 'package:flutter/material.dart';

class Hmslider extends StatefulWidget {
  Hmslider({Key? key}) : super(key: key);

  @override
  _HmsliderState createState() => _HmsliderState();
}

class _HmsliderState extends State<Hmslider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
