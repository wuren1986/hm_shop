import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // 提示消息
        width: 120,
        shape: RoundedRectangleBorder(
          // 提示框圆角
          borderRadius: BorderRadius.circular(40),
        ),
        behavior: SnackBarBehavior.floating, // 浮动显示
        duration: Duration(seconds: 5), // 显示时长
        content: Text(message ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
