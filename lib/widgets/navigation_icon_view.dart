import 'package:flutter/cupertino.dart';

class NavigationIconView{
  // 封装一下底部的导航按钮
  final BottomNavigationBarItem item;
  //title
  final  String title;
  //icon path
  final String iconPath;
  //actived icon path
  final String activeIconPath;

  NavigationIconView(
      {@required this.title,
       @required this.iconPath,
        @required this.activeIconPath})
        :item = BottomNavigationBarItem(
          icon: Image.asset(iconPath,width: 20,height: 20),
          activeIcon: Image.asset(activeIconPath,width: 20,height: 20),
          title:  Text(title)
        );

}