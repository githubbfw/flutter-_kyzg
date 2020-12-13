import 'package:flutter/material.dart';
import 'package:flutterkyzg/pages/about.dart';
import 'package:flutterkyzg/pages/publish_tweet_page.dart';
import 'package:flutterkyzg/pages/settingpage.dart';
import 'package:flutterkyzg/pages/tweet_black_house.dart';

class MyDrawer extends StatelessWidget {
  final String headImgPath;
  final List menuTitles;
  final List menuIcons;

  const MyDrawer({Key key, this.headImgPath, this.menuTitles, this.menuIcons})
      : assert(headImgPath != null),
        assert(menuTitles != null),
        assert(menuIcons != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      elevation: 0,
      child: ListView.separated(
        // 解决状态栏问题
        padding: EdgeInsets.all(0),
          // 这个是带有分割线的listview
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Image.asset(
                headImgPath,
                fit: BoxFit.cover,
              );
            }
//            ;
            index -= 1;
// 这个时候，index的值就是从0，1,2.。。。这样
            return ListTile(
              leading: Icon(menuIcons[index]),
              title: Text(menuTitles[index]),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                switch (index) {
                  case 0:
                  //PublishTweetPage
                    _navigatorPush(context, PublishTweetPage());
                    break;
                  case 1:
                  //TweetBlackHousePage
                    _navigatorPush(context, TweetBlackHousePage());
                    break;
                  case 2:
                  //AboutPage
                    _navigatorPush(context, AboutPage());
                    break;
                  case 3:
                  //SettingsPage
                    _navigatorPush(context, SettingPage());
                    break;
                }
              },
            );
          },
          separatorBuilder: (BuildContext context, int index){
            if(index == 0){  //0 1 2 3
              return Divider(height: 0);
            }else{
              return Divider(height: 1);
            }
          },
          itemCount: menuTitles.length +1// 有个头部图片
          ),
    );
  }
}

// 写一个跳转的方法。
_navigatorPush(BuildContext context, Widget widget) {
//  Navigator.of(context).pop();// 把drawer收起来  关闭之后，就很别扭。
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
