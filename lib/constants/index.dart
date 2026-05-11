// 全局常量
class GlobalConstants {
  static const String BASE_URL = 'https://meikou-api.itheima.net'; // 基础地址
  static const int TIME_OUT = 10000; // 超时时间，单位毫秒
  static const String SUCCESS_CODE = '1'; // 成功状态码
}

// 存放请求地址接口的常量
class HttpConstants {
  static const String BANNER_LIST = '/home/banner'; // 轮播图地址
  static const String CATEGORY_LIST = '/home/category/head'; // 分类列表地址
  static const String PRODUCT_LIST = '/hot/preference'; // 特惠推荐地址
  static const String IN_VOGUE_LIST = "/hot/inVogue"; // 热榜推荐地址
  static const String ONE_STOP_LIST = "/hot/oneStop"; // 一站式推荐地址
  static const String RECOMMEND_LIST = "/home/recommend"; // 推荐列表
  static const String GUESS_LIST = "/home/goods/guessLike"; // 猜你喜欢地址
  static const String LOGIN = "/login"; // 登录接口地址
}
