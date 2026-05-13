// 分类组件
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryItems;
  const HmCategory({super.key, required this.categoryItems});

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    // 返回一个横向滚动组件，需要设置一个高度，否则无法显示
    return SizedBox(
      height: 100,
      // ListView外层要包SizeBox或者Container组件确定高度，否则无法显示
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 横向排列
        itemCount: widget.categoryItems.length,
        itemBuilder: (context, index) {
          // 从widget中获取分类列表数据
          final category = widget.categoryItems[index];
          return Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture ?? "", width: 40, height: 40),
                Text(
                  category.name ?? "",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
