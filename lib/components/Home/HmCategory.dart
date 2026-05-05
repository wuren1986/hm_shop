// 分类组件
import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  HmCategory({Key? key}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    // 返回一个横向滚动组件，需要设置一个高度，否则无法显示
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 横向排列
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            height: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "分类$index",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
