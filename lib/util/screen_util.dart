import 'package:flutter/material.dart';

class ScreenUtil {
  ///获取屏幕宽高
  static Size get(BuildContext context) {
    return MediaQuery.of(context).size;
  }
  ///获取状态栏高度
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
}
