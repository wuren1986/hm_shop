import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 轮播图数据列表
  final List<BannerItem> _bannerItems = [
    BannerItem(
      id: "1",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    ),
    BannerItem(
      id: "2",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
    ),
    BannerItem(
      id: "3",
      imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    ),
  ];

  // 获取滚动容器的内容
  List<Widget> _getScrollChildern() {
    return [
      // 包括普通widget的sliver
      SliverToBoxAdapter(child: Hmslider(bannerList: _bannerItems)), // 轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), // 间距主键
      // SliverGrid 和 SliverList 只能纵向排列
      SliverToBoxAdapter(child: HmCategory()), // 分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), // 间距主键
      SliverToBoxAdapter(child: HmSuggestion()), // 推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), // 间距主键
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)), // 间距主键
      HmMorelist(), // 无限滚动组件
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildern()); // 必须是 sliver 家族的内容
  }
}
