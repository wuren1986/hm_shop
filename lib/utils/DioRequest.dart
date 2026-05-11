// 基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio(); // dio请求对象

  // 基础地址拦截器
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(milliseconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(milliseconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(milliseconds: GlobalConstants.TIME_OUT);

    // 添加拦截器
    _addInterceptor();
  }

  // 添加拦截器
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 请求拦截器
        onRequest: (options, handler) {
          return handler.next(options);
        },
        // 响应拦截器
        onResponse: (response, handler) {
          // http状态码 200 300
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            // 成功状态码
            // 处理业务状态码
            return handler.next(response);
          }
          // 其他状态码
          return handler.reject(
            DioException(requestOptions: response.requestOptions),
          );
        },
        // 错误拦截器
        onError: (error, handler) {
          // return handler.reject(error);
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data["msg"] ?? "请求失败",
            ),
          );
        },
      ),
    );
  }

  // 封装get请求方法
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // 封装post请求方法
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  // 进一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>; // data才是接口放回的业务数据
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        // http状态和业务状态均正常，可以正常放行通过
        return data["result"];
      }
      // 抛出异常
      throw DioException(
        requestOptions: res.requestOptions,
        message: data["msg"] ?? "加载数据失败",
      );
    } catch (e) {
      // 处理异常
      rethrow; // 不改变原来抛出的异常信息
    }
  }
}

// 单例对象
final dioRequest = DioRequest();

// dio请求工具发出请求 返回的数据 Response<dynamic>.data
// 把所有的接口的data解构出来 拿到真正的数据 要判断业务状态码是否等于1（成功）
// 如果等于1，说明业务状态正常，返回数据
// 如果不等于1，说明业务状态异常，抛出异常
