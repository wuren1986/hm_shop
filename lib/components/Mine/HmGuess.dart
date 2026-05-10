// 猜你喜欢
import 'package:flutter/material.dart';

class HmGuess extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // 渲染内容
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '猜你喜欢',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  // 最大高度
  double get maxExtent => 60;

  @override
  // 最小高度
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // 不重新构建
    return false;
  }
}
