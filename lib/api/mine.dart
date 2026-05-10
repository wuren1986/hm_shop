import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<GoodsDetailItems> getGuessListAPI(Map<String, dynamic> params) async {
  final response = await dioRequest.get(
    HttpConstants.GUESS_LIST,
    params: params,
  );
  return GoodsDetailItems.formJSON(response);
}
