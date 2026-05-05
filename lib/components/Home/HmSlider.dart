// 轮播图组件
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

// 安装轮播图插件 flutter pub add carousel_slider

class Hmslider extends StatefulWidget {
  final List<BannerItem> bannerList;

  Hmslider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmsliderState createState() => _HmsliderState();
}

class _HmsliderState extends State<Hmslider> {
  // 返回轮播图插件
  Widget _getSlider() {
    // 在 Flutter 中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;

    // 根据数据渲染不同的轮播选项
    return CarouselSlider(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider()]);
    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 20)),
    // );
  }
}
