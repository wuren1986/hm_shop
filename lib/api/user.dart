// 登录接口API
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> data) async {
  final response = await dioRequest.post(HttpConstants.LOGIN, data: data);
  return UserInfo.fromJSON(response);
}
