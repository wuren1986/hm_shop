// 无限滚动组件
import 'package:flutter/material.dart';

class HmMorelist extends StatefulWidget {
  HmMorelist({Key? key}) : super(key: key);

  @override
  _HmMorelistState createState() => _HmMorelistState();
}

class _HmMorelistState extends State<HmMorelist> {
  @override
  Widget build(BuildContext context) {
    // 必须是 Sliver 家族的组件
    // 按需加载
    return SliverGrid.builder(
      // 网格是两列
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blue,
          height: 200,
          alignment: Alignment.center,
          child: Text(
            "商品$index",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      },
    );
  }
}
