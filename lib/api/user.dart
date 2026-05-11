// 登录接口API
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

// 登录接口API
Future<UserInfo> loginAPI(Map<String, dynamic> data) async {
  final response = await dioRequest.post(HttpConstants.LOGIN, data: data);
  return UserInfo.fromJSON(response);
}

// 获取用户信息接口API
Future<UserInfo> getUserInfoAPI() async {
  final response = await dioRequest.get(HttpConstants.USER_PROFILE);
  return UserInfo.fromJSON(response);
}
