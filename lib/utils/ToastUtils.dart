import 'package:flutter/material.dart';

class ToastUtils {
  // 控制显示状态
  static bool showLoading = false; // 是否正在显示提示提示

  static void showToast(BuildContext context, String? message) {
    // 限制当前只能显示一个提示
    if (ToastUtils.showLoading) {
      return;
    }
    ToastUtils.showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      ToastUtils.showLoading = false;
    });

    // 显示提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // 提示消息
        width: 180,
        shape: RoundedRectangleBorder(
          // 提示框圆角
          borderRadius: BorderRadius.circular(40),
        ),
        behavior: SnackBarBehavior.floating, // 浮动显示
        duration: Duration(seconds: 3), // 显示时长
        content: Text(message ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
