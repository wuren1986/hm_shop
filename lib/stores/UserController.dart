import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hm_shop/viewmodels/user.dart';

/// GetX用法
/// 1.安装getx插件
/// 2.定义一个继承GetxController的对象
/// 3.对象中定义需要共享的属性
/// 数据需要响应式更新-需要给初始值.obs结尾
/// UI显示Getx数据需使用Obx包裹函数中使用
/// 6.UI中使用Getx需要一个put和find动作
/// 7.必须先put一次，才可以find
/// 8.put仅一次，find可多次

// 需要共享的对象 要有一些共享的属性 属性需要响应式更新
class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs; // .obs表示该数据为响应式数据，user对象被监听
  // 想要取 obs 装饰的对象值 需要通过 user.value
  // 更新用户信息
  void updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }

  // 清空用户信息
  void clearUserInfo() {
    user.value = UserInfo.fromJSON({});
  }
}
