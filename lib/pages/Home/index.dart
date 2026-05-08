import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
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
  List<BannerItem> _bannerItems = [
    // BannerItem(
    //   id: "1",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    // ),
    // BannerItem(
    //   id: "2",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
    // ),
    // BannerItem(
    //   id: "3",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    // ),
  ];
  // 分类列表数据列表
  List<CategoryItem> _categoryItems = [];
  // 特惠推荐数据
  RecommendResult? _recommendResult;

  // 获取滚动容器的内容
  List<Widget> _getScrollChildern() {
    return [
      // 包括普通widget的sliver
      SliverToBoxAdapter(child: Hmslider(bannerList: _bannerItems)), // 轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), // 间距主键
      // SliverGrid 和 SliverList 只能纵向排列
      SliverToBoxAdapter(
        child: HmCategory(categoryItems: _categoryItems),
      ), // 分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), // 间距主键
      SliverToBoxAdapter(
        child: HmSuggestion(recommendResult: _recommendResult),
      ), // 推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), // 间距主键
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)), // 间距主键
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  // 热榜推荐
  RecommendResult _inVogueResult = RecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  RecommendResult _oneStopResult = RecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 获取推荐列表
  void _getRecommendList() async {
    _recommendList = await getRecommendListAPI({"limit": 10});
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getProductList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
  }

  // 获取轮播图数据
  Future<void> _getBannerList() async {
    final bannerList = await getBannerListAPI();
    setState(() {
      _bannerItems = bannerList;
    });
  }

  // 获取分类列表数据
  Future<void> _getCategoryList() async {
    final categoryList = await getCategoryListAPI();
    setState(() {
      _categoryItems = categoryList;
    });
  }

  // 获取特惠推荐数据
  Future<void> _getProductList() async {
    final recommendResult = await getProductListAPI();
    setState(() {
      _recommendResult = recommendResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildern()); // 必须是 sliver 家族的内容
  }
}
