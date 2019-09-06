import 'package:flutter/material.dart';

class WidgetGet {
  static AppBar getAppBar(String title) {
    return AppBar(
      backgroundColor: Color(0XFF2D3231),
      title: Text(title),
      centerTitle: false,
    );
  }

  static AppBar operationBar(String title, VoidCallback callBack) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Color(0XFF2D3231),
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
                onTap: callBack,
                child: Icon(
                  Icons.menu,
                  color: Color(0xff46cbaa),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget titleBar(Size size, String title, VoidCallback callBack) {
    return Container(
      width: size.width,
      color: Color(0XFF2D3231),
      height: 45, //固定45
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: GestureDetector(
                onTap: callBack,
                child: Icon(
                  Icons.menu,
                  color: Color(0xff46cbaa),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              title,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
