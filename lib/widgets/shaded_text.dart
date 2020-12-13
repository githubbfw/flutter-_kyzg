import 'package:flutter/material.dart';

//todo: 这里是自定义一个平移效果的text的 widget

// 定义一个方法
typedef ShadeBuilder = Widget Function(BuildContext context,String text,Color color);

class ShadeText extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color shadeColor;
  final double xTans;
  final double yTans;
  final ShadeBuilder shadeBuilder;

  const ShadeText(
      {Key key,
      this.text,
      this.textColor,
      this.shadeColor,
      this.xTans,
      this.yTans,
      this.shadeBuilder})
      : assert(text != null),
        assert(textColor != null),
        assert(shadeColor != null),
        assert(shadeBuilder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        shadeBuilder(context,text,textColor),// 第一个组件
        Transform(
            transform: Matrix4.translationValues(xTans??10, yTans??10, 0),
          child: shadeBuilder(context,text,shadeColor),
        ),// 第二个组件

      ],
    );
  }
}
