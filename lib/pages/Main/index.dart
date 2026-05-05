import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据 根据数据进行动态渲染4个导航
  // 一般应用该程序的导航是固定的
  final List<Map<String, dynamic>> _tabList = [
    {
      'icon': "lib/assets/ic_public_home_normal.png", // 正常显示的图标
      'active_icon': "lib/assets/ic_public_home_active.png", // 激活状态的图标
      'title': '首页',
    },
    {
      'icon': "lib/assets/ic_public_pro_normal.png", // 正常显示的图标
      'active_icon': "lib/assets/ic_public_pro_active.png", // 激活状态的图标
      'title': '分类',
    },
    {
      'icon': "lib/assets/ic_public_cart_normal.png", // 正常显示的图标
      'active_icon': "lib/assets/ic_public_cart_active.png", // 激活状态的图标
      'title': '购物车',
    },
    {
      'icon': "lib/assets/ic_public_my_normal.png", // 正常显示的图标
      'active_icon': "lib/assets/ic_public_my_active.png", // 激活状态的图标
      'title': '我的',
    },
  ];

  // 定义当前激活的索引
  int _currentIndex = 0;

  // 返回底部导航栏的组件
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return _tabList
        .map(
          (item) => BottomNavigationBarItem(
            icon: Image.asset(item['icon'], width: 30, height: 30), // 正常显示图标
            activeIcon: Image.asset(item['active_icon']), // 激活显示图标
            label: item['title'], // 标题
          ),
        )
        .toList();
  }

  // 返回子组件
  List<Widget> _getChildWidget() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea 安全区域 避免导航栏遮挡内容
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildWidget()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航栏
        items: _getTabBarWidget(),
        currentIndex: _currentIndex, // 默认激活索引
        selectedItemColor: Colors.black, // 激活状态的颜色
        showUnselectedLabels: true, // 显示未激活状态的标签
        unselectedItemColor: Colors.black, // 未激活状态的颜色
        onTap: (index) {
          // index 入参就是当前点击的索引
          setState(() {
            _currentIndex = index; // 切换索引
          });
        },
      ),
    );
  }
}
