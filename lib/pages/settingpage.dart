import 'package:flutter/material.dart';
import 'package:flutterkyzg/common/event_bus.dart';
import 'package:flutterkyzg/constants/constants.dart';
import 'package:flutterkyzg/utils/data_utils.dart';

// 这个界面搞一个 退出 的操作
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            '设置',
            style: TextStyle(color: Color(AppColors.APPBAR)),
          ),
          iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
        ),
      body: Container(
        child:Center(
          // 退出登录
          child:FlatButton(
              onPressed: (){
                DataUtils.clearLoginInfo().then((_){
                  eventBus.fire(LogoutEvent());
                  Navigator.of(context).pop();
                });
              },
              child: null),
         )
        ),
    );
  }
}
