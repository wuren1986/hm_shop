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

  int _page = 1; // 页码
  bool _isLoading = false; // 当前是否正在加载推荐列表数据，当前加载状态
  bool _hasMore = true; // 是否还有下一页
  int _pageSize = 8; // 每页数量
  // 获取推荐列表
  void _getRecommendList() async {
    // 当前正在加载推荐列表数据时，不重复加载 或 没有下一页数据了，则不进行加载
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true; // 更新加载状态，开始加载
    int requestLimit = _page * _pageSize;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false; // 更新加载状态，结束加载
    setState(() {});
    if (_recommendList.length < requestLimit) {
      _hasMore = false; // 更新是否还有下一页数据
      return;
    }
    _page++; // 更新页码
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
    _registerEvent();
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    // 监听滚动到底部的事件
    _scrollController.addListener(() {
      // _scrollController.position.pixels // 滚动距离
      // _scrollController.position.maxScrollExtent; // 最大滚动距离
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        // 加载下一页数据
        _getRecommendList();
      }
    });
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

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildern(),
      controller: _scrollController, // 绑定控制器
    ); // 必须是 sliver 家族的内容
  }
}
