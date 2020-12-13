import 'package:flutter/material.dart';
import 'package:flutterkyzg/pages/discoverpage.dart';
import 'package:flutterkyzg/pages/newslistpage.dart';
import 'package:flutterkyzg/pages/profilepage.dart';
import 'package:flutterkyzg/pages/tweetpage.dart';
import 'package:flutterkyzg/widgets/mydrawer.dart';
import 'package:flutterkyzg/widgets/navigation_icon_view.dart';
import 'constants/constants.dart';

// 搭建项目，可以按照这个来
// https://blog.csdn.net/weixin_42215775/article/details/100938881
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final  appBarTitle = ['资讯','动弹','发现','我的',];
  List<NavigationIconView> _navigationIconsViews;
  var  _currentIndex = 0 ;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationIconsViews = [
      NavigationIconView(
        title: '资讯',
        iconPath: 'assets/images/ic_nav_news_normal.png',
        activeIconPath: 'assets/images/ic_nav_news_actived.png'
      ),
      NavigationIconView(
          title: '动弹',
          iconPath: 'assets/images/ic_nav_tweet_normal.png',
          activeIconPath: 'assets/images/ic_nav_tweet_actived.png'
      ),
      NavigationIconView(
          title: '发现',
          iconPath: 'assets/images/ic_nav_discover_normal.png',
          activeIconPath: 'assets/images/ic_nav_discover_actived.png'
      ),
      NavigationIconView(
          title: '我的',
          iconPath: 'assets/images/ic_nav_my_normal.png',
          activeIconPath: 'assets/images/ic_nav_my_pressed.png'
      ),


    ];
    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoverPage(),
      ProfilePage(),
    ];

    _pageController = PageController(initialPage: _currentIndex); // 这个可以设置是显示的第一个界面是那一个。

  }





  @override
  Widget build(BuildContext context) {
    // safeArea 可以适配刘海屏登异形屏
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
            appBarTitle[_currentIndex],
          style: TextStyle(color: Color(AppColors.APPBAR),
        ),
      ),
        iconTheme:IconThemeData(color: Color(AppColors.APPBAR)) ,
    ),
      body:PageView.builder(
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
          itemBuilder: (BuildContext context, int index){
            return _pages[index];
          },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index){
            setState(() {
              _currentIndex = index;
            });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: _navigationIconsViews.map((view)=>view.item).toList(),
        onTap: (index){
          setState(() {
            _currentIndex = index;
            //todo:动画切换页面 === 注意一定要这个，如果直接用pageview就不需要这样的
            _pageController.animateToPage(index,
                duration: Duration(microseconds: 1), curve: Curves.ease);
          });
        },
      ),
      drawer: MyDrawer(
       headImgPath: 'assets/images/cover_img.jpg',
        menuTitles: ['发布动弹', '动弹小黑屋', '关于', '设置'],
        menuIcons: [Icons.send, Icons.home, Icons.error, Icons.settings],
      ),
    );
  }
}
