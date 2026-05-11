import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context, {String message = "加载中..."}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(), // 转圈的组件
                  SizedBox(height: 10),
                  Text(message),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context, {String? message = "加载中..."}) {
    Navigator.pop(context);
  }
}
