// 管理路由
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Main/index.dart';
import 'package:hm_shop/pages/Login/index.dart';

// 返回App根级别组件
Widget getRootWidget() {
  return MaterialApp(
    // 配置路由
    initialRoute: '/',
    routes: getRootRoutes(),
  );
}

// 返回该App的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    '/': (context) => MainPage(), // 主页路由
    '/login': (context) => LoginPage(), // 登录路由
  };
}
