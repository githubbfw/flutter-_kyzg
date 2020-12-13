import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterkyzg/common/event_bus.dart';
import 'package:flutterkyzg/constants/constants.dart';
import 'package:flutterkyzg/pages/profile_detail_page.dart';
import 'package:flutterkyzg/utils/data_utils.dart';
import 'package:flutterkyzg/utils/net_utils.dart';

import 'login_web_page.dart';
import 'mymessagepage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = [
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];
  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
  ];

  String userAvatar;
  String userName;

  @override
  void initState() {
    super.initState();

    _showUserInfo();
    // 这个是事件的订阅 信息。 ??? 为什么要在iniit这个方法里面去接受。
    eventBus.on<LoginEvent>().listen((event) {
      //TODO获取用户信息并显示   通过接口（token）来获取用户信息。
      _getUserInfo();
    });
    // 退出了
    eventBus.on<LogoutEvent>().listen((event) {
      _showUserInfo();
    });
  }



  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.separated(
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _buildHeader();
              }
              index -= 1;
              return ListTile(
                leading: Icon(menuIcons[index]),
                title: Text(menuTitles[index]),
                trailing: Icon(Icons.arrow_forward_ios),
                // 每个子项的点击
                onTap: (){
                  DataUtils.isLogin().then((isLogin){
                    if(isLogin){
                      switch(index){
                        case 0:
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyMessagePage()));
                          break;
                      }
                    }else{
                      _login();
                    }

                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Divider(
                  height: 0,
                );
              }
              return Divider(
                color: Colors.red,
              );
            },
            itemCount: menuTitles.length));
  }

  //显示用户信息。
  void _getUserInfo() {
    DataUtils.getAccessToken().then((accessToken) {
      if (accessToken == null || accessToken.length == 0) {
        return;
      }

      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = accessToken;
      params['dataType'] = 'json';
      print('accessToken: $accessToken');

      NetUtils.get(AppUrls.OPENAPI_USER, params).then((data) {
        //{"gender":"male","name":"Damon2019","location":"湖南 长沙","id":2006874,"avatar":"https://oscimg.oschina.net/oscnet/up-21zvuaor7bbvi8h2a4g93iv9vve2wrnz.jpg!/both/50x50?t=1554975223000","email":"3262663349@qq.com","url":"https://my.oschina.net/damon007"}
        print('data: $data');
        Map<String, dynamic> map = json.decode(data);
        if (mounted) {
          setState(() {
            userAvatar = map['avatar'];
            userName = map['name'];
          });
        }
        DataUtils.saveLoingInfo(map);
      });
    });
  }

  // 获取用户信息
  _showUserInfo() {
    DataUtils.getUserInfo().then((user) {
      if (mounted) {
        setState(() {
          if (user != null) {
            userAvatar = user.avatar;
            userName = user.name;
          } else {
            userAvatar = null;
            userName = null;
          }
        });
      }
    });
  }

  // 点击头像登陆的调用 --- 跳转到登陆界面
  _login() async {
    // 授权登陆成功，通知界面刷新
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));

    if (result != null && result == 'refresh') {
      // todo：登陆成功  开启一个事件处理。 然后传到事务处理的地方，（在initState里面）
      // https://www.cnblogs.com/upwgh/p/13159064.html
      eventBus.fire(LoginEvent());
    }
  }

  Widget _buildHeader() {
    return Container(
      color: Color(AppColors.APP_THEME),
      height: 160,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: userAvatar != null
                  ? Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xffffffff),
                          width: 2.0,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(userAvatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Image.asset(
                      'assets/images/ic_avatar_default.png',
                      width: 60.0,
                      height: 60.0,
                    ),
              onTap: () {
                // 判断是否登陆
                DataUtils.isLogin().then((isLogin){
                  if(isLogin){
                    // 详情 界面
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileDetailPage()));
                  }else{
                    //todo:执行登录
                    _login();
                  }
                });

              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              userName ??= '点击头像登录',
              style: TextStyle(color: Color(0xffffffff)),
            )
          ],
        ),
      ),
    );
  }
}
