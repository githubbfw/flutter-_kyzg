import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterkyzg/constants/constants.dart';
import 'package:flutterkyzg/main.dart';
import 'package:flutterkyzg/utils/data_utils.dart';
import 'package:flutterkyzg/utils/net_utils.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((url) {
      // 对url进行监听。
      // https://www.oschina.net/action/oauth2/authorize?
      // response_type=code&client_id=6i4Yu6IUqXnR64em0rsJ&redirect_uri=https://www.dongnaoedu.com/
      print('LoginWebPage onUrlChanged: $url');
      if (mounted) {
        // 这个是判断，改节点是不是在树上
        setState(() {
          //菊花圈 消失
          isLoading = false;
        });
      }

      // 网页点击连接 之后，会返回一个 url 链接 。
      // https://www.dongnaoedu.com/?code=6hHYoH&state=
      // 我们需要得到里面的code值
       if(url != null && url.length>0 &&url.contains('?code')){
         // 登陆成功 了
         // 提取 授权码 code
         String code = url.split('?')[1].split('&')[0].split('=')[1];
         print("提取 授权码  ${code}");

         Map<String, dynamic> params = Map<String ,dynamic>();
         params['client_id'] =  AppInfos.CLIENT_ID;
         params['client_secret'] =  AppInfos.CLIENT_SECRET;
         params['grant_type'] =  'authorization_code';
         params['redirect_uri'] =  AppInfos.REDIRECT_URI;
         params['code'] =  '$code';
         params['dataType'] =  'json';

         NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data){
    //{"access_token":"aa105aaf-ca4f-4458-822d-1ae6a1fa33f9","refresh_token":"daae8b80-3ca6-4514-a8ae-acb3a82c951c","uid":2006874,"token_type":"bearer","expires_in":510070}
           print('$data');
          if(data !=null){
            Map<String, dynamic> map = json.decode(data);
            if(map!= null && map.isNotEmpty){
              //保存token等信息--使用 shared_preferences
             DataUtils.saveLoingInfo(map);
             // 弹出当前路由  并返回refresh通知我的界面刷新数据  --- 到个人界面去了
              Navigator.pop(context,'refresh');

            }
          }

         });



       }



    });
  }

  @override
  Widget build(BuildContext context) {
    //authorize?response_type=code&client_id=s6BhdRkqt3&state=xyz&redirect_uri=https
    List<Widget> _appBarTitle = [
      Text(
        '登录开源中国',
        style: TextStyle(
          color: Color(AppColors.APPBAR),
        ),
      ),
    ];
    if(isLoading){ // 请求等待
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }

    return WebviewScaffold(
      url:AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=' +
          AppInfos.CLIENT_ID +
          '&redirect_uri=' +
          AppInfos.REDIRECT_URI,
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,

        ),
      ),
      //允许执行js
      withJavascript: true,
      //允许本地存储
      withLocalStorage: true,
      withZoom: true,
    );
  }
}
