import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * 持久化Token
* 1.安装shared_preferences插件
* 2.封装一个TokenManager工具，具备初始化/设置/获取/删除方法
* 3.登录成功将token写入持久化
* 4.封装获取用户信息API
* 5.Dio在请求工具中进行token注入
* 在应用首页判断token获取状态赋值Getx数据	
* 调整我的页面的Getx的put方式为find方式
 */

class TokenManager {
  // 返回持久化对象的实例对象
  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  String _token = "";

  // 初始化tonen
  Future<void> init() async {
    // 1.获取持久化实例
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // 设置token
  Future<void> setToken(String val) async {
    // 1.获取持久化实例
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val); // 将token写入到持久化磁盘
    _token = val; // 内存值
  }

  // 获取token
  String getToken() {
    return _token;
  }

  // 删除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = ""; // 内存值
  }
}

final tokenManager = TokenManager();
