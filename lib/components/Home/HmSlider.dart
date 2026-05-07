// 轮播图组件
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

// 安装轮播图插件 flutter pub add carousel_slider
/**
 * 获取轮播图数据，步骤
 * 1.安装dio：flutter pub add dio
 * 2.定义常量数据、基础地址、超时时间、业务状态、请求地址
 * 3.封装网络请求工具，基础地址，拦截器
 * 4.请求工具进一步结构，处理http状态和业务状态
 * 5.类工厂转化动态类型到对象类型
 * 6.封装请求API调用工厂函数
 * 7.初始化数据更新状态
 * 
 * 接口基础地址：https://meikou-api.itheima.net
 * 轮播图地址（get）：https://meikou-api.itheima.net/home/banner
 * 
 * 
 */

class Hmslider extends StatefulWidget {
  final List<BannerItem> bannerList;

  Hmslider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmsliderState createState() => _HmsliderState();
}

class _HmsliderState extends State<Hmslider> {
  // 轮播图控制器
  CarouselSliderController _controller = CarouselSliderController();

  // 当前轮播图激活的索引
  int _currentIndex = 0;

  // 返回轮播图插件
  Widget _getSlider() {
    // 在 Flutter 中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;

    // 根据数据渲染不同的轮播选项
    return CarouselSlider(
      carouselController: _controller, // 绑定controller对象
      items: widget.bannerList
          .map(
            (e) =>
                Image.network(e.imgUrl!, fit: BoxFit.cover, width: screenWidth),
          )
          .toList(),
      options: CarouselOptions(
        height: 300, // 轮播图高度
        autoPlay: true, // 自动播放
        autoPlayInterval: Duration(seconds: 3), // 自动播放间隔
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          // 切换轮播图时触发，更新当前索引
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // 返回搜索框组件
  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            "搜索...",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  // 返回指示灯导航组件
  Widget _getIndicator() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 主轴居中
          children: [
            for (int i = 0; i < widget.bannerList.length; i++)
              GestureDetector(
                onTap: () {
                  // 点击指示灯切换轮播图
                  _controller.animateToPage(i);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 6,
                  width: i == _currentIndex ? 40 : 20,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: i == _currentIndex
                        ? Colors.white
                        : Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider(), _getSearch(), _getIndicator()]);
    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    // );
  }
}
