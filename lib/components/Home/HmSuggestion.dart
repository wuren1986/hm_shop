// 推荐组件
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  final RecommendResult? recommendResult;
  HmSuggestion({Key? key, this.recommendResult}) : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  // 取前3条数据
  List<GoodsItem> _getDisplayItems() {
    if (widget.recommendResult == null ||
        widget.recommendResult!.subTypes.isEmpty)
      return [];
    return widget.recommendResult!.subTypes.first.goodsItems?.items!
            .take(3)
            .toList() ??
        [];
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getDisplayItems(); // 取到前3条数据
    return list.map((item) {
      return Expanded(
        child: Column(
          children: [
            // ClipRRect 可以包裹子元素 裁剪图片设置圆角
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                errorBuilder: (context, error, stackTrace) {
                  // 当图片加载失败时，返回默认图片
                  return Image.asset(
                    "lib/assets/home_cmd_inner.png",
                    width: 100,
                    height: 140,
                  );
                },
                item.picture ?? '',
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "￥${item.price}",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 240, 96, 12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            ),
          ],
        ),
      );
    }).toList();
  }

  // 顶部结构
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(
            color: Color.fromARGB(255, 124, 63, 58),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // 左侧结构
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 完成渲染
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        // height: 300,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"), // 设置背景图片
            fit: BoxFit.cover, // 图片等比例缩放
          ),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeft(),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getChildrenList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
