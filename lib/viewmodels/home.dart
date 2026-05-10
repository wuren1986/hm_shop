// 定义首页轮播图数据对象类型
class BannerItem {
  String? id;
  String? imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 扩展一个工厂函数，一般使用factory来声明，一般用来创建实例对象
  factory BannerItem.formJSON(Map<String, dynamic> json) {
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

// flutter必须强制转换类型，没有隐式转换

// {
//       "id": "1181622001",
//       "name": "气质女装",
//       "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png",
//       "children": [
//         {
//           "id": "1191110001",
//           "name": "半裙",
//           "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bq.png?quality=95&imageView",
//           "children": null,
//           "goods": null
//         },
//         {
//           "id": "1191110002",
//           "name": "衬衫",
//           "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_cs.png?quality=95&imageView",
//           "children": null,
//           "goods": null
//         },
//         {
//           "id": "1191110022",
//           "name": "T恤",
//           "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_tx.png?quality=95&imageView",
//           "children": null,
//           "goods": null
//         },
//         {
//           "id": "1191110023",
//           "name": "针织衫",
//           "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_zzs.png?quality=95&imageView",
//           "children": null,
//           "goods": null
//         },
//         {
//           "id": "1191110024",
//           "name": "夹克",
//           "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_jk.png?quality=95&imageView",
//           "children": null,
//           "goods": null
//         },
//         {
//           "id": "1191110025",
//           "name": "卫衣",
//           "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_wy.png?quality=95&imageView",
//           "children": null,
//           "goods": null
//         },
//         {
//           "id": "1191110028",
//           "name": "背心",
//           "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bx.png?quality=95&imageView",
//           "children": null,
//           "goods": null
//         }
//       ],
//       "goods": null
//     }

// 根据json编写class对象和工厂转换函数
class CategoryItem {
  String? id;
  String? name;
  String? picture;
  List<CategoryItem>? children;
  List<CategoryItem>? goods;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });
  // 扩展一个工厂函数，一般使用factory来声明，一般用来创建实例对象
  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] == null
          ? []
          : (json["children"] as List)
                .map<CategoryItem>((e) => CategoryItem.formJSON(e))
                .toList(),
      goods: json["goods"] == null
          ? []
          : (json["goods"] as List)
                .map<CategoryItem>((e) => CategoryItem.formJSON(e))
                .toList(),
    );
  }
}

// 特惠推荐数据类型
// result.subTypes[].goodsItems.items[] 对应的商品条目
class GoodsItem {
  String? id;
  String? name;
  String? desc;
  String? price;
  String? picture;
  int? orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.formJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"],
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}

// result.subTypes[].goodsItems 对应的分页商品列表
class GoodsItems {
  int? counts;
  int? pageSize;
  int? pages;
  int? page;
  List<GoodsItem>? items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.formJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items:
          (json["items"] as List?)
              ?.map<GoodsItem>((e) => GoodsItem.formJSON(e))
              .toList() ??
          [],
    );
  }
}

// result.subTypes[] 对应的子分类
class SubTypeItem {
  String? id;
  String? title;
  GoodsItems? goodsItems;
  SubTypeItem({
    required this.id,
    required this.title,
    required this.goodsItems,
  });
  factory SubTypeItem.formJSON(Map<String, dynamic> json) {
    return SubTypeItem(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: json["goodsItems"] == null
          ? null
          : GoodsItems.formJSON(json["goodsItems"]),
    );
  }
}

// result 对应的特惠推荐顶层数据
class RecommendResult {
  String? id;
  String? title;
  List<SubTypeItem> subTypes;
  RecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory RecommendResult.formJSON(Map<String, dynamic> json) {
    return RecommendResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes:
          (json["subTypes"] as List?)
              ?.map<SubTypeItem>((e) => SubTypeItem.formJSON(e))
              .toList() ??
          [],
    );
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}

class GoodsDetailItems {
  int? counts;
  int? pageSize;
  int? pages;
  int? page;
  List<GoodDetailItem>? items;
  GoodsDetailItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsDetailItems.formJSON(Map<String, dynamic> json) {
    return GoodsDetailItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items:
          (json["items"] as List?)
              ?.map<GoodDetailItem>((e) => GoodDetailItem.formJSON(e))
              .toList() ??
          [],
    );
  }
}
