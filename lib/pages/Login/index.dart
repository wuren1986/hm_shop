import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/utils/LoadingDialog.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController =
      TextEditingController(); // 账号控制器
  final TextEditingController _codeController =
      TextEditingController(); // 密码控制器
  final UserController _userController = Get.find(); // 寻找对象

  // 用户账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      // 配合Form组件可以实现表单校验
      validator: (value) {
        // 表单校验
        if (value == null || value.isEmpty) {
          return '账号不能为空';
        }
        if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
          return '请输入正确的手机号';
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      // 配合Form组件可以实现表单校验
      validator: (value) {
        // 表单校验
        if (value == null || value.isEmpty) {
          return '密码不能为空';
        }
        // 密码校验 6-16位的数字字母或下划线
        if (!RegExp(r'^[a-zA-Z0-9_]{6,16}$').hasMatch(value)) {
          return '请输入6-16位的数字字母或下划线';
        }
        return null;
      },
      controller: _codeController,
      obscureText: true, // 隐藏密码
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 登录方法
  Future<void> _login() async {
    // 调用登录接口
    try {
      LoadingDialog.show(context, message: "努力登录中"); // 显示加载弹窗
      // 账号：13200000001 - 13200000010
      // 密码：123456
      final res = await loginAPI({
        "account": _phoneController.text,
        "password": _codeController.text,
      });
      // 保存用户信息
      _userController.updateUserInfo(res);
      tokenManager.setToken(res.token); // 写入持久化

      LoadingDialog.hide(context); // 隐藏加载弹窗
      ToastUtils.showToast(context, "登录成功");
      Navigator.pop(context); // 返回上个页面
    } catch (e) {
      LoadingDialog.hide(context); // 隐藏加载弹窗
      ToastUtils.showToast(context, (e as DioException).message);
    }
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if (_formKey.currentState!.validate()) {
            // 对复选框状态进行校验
            if (_isChecked) {
              // 登录逻辑
              _login();
            } else {
              // 提示用户勾选用户协议
              ToastUtils.showToast(context, "请先同意隐私条款和用户协议");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  bool _isChecked = false;
  // 勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            // 切换勾选状态
            setState(() {
              _isChecked = value ?? false;
            });
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Form(
        // 表单组件
        key: _formKey, // 绑定GlobalKey，用于校验表单数据
        // 表单校验
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
