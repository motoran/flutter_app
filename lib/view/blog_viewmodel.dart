import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/member_data.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogViewModel extends ChangeNotifier {
  WebViewController webViewController;
  final MemberData memberData = MemberData();
  final String memberName;
  final int blogIndex;

  var contentWidgets = List<Widget>();

  int pageIndex = 0;
  bool loadingFlag = true;
  var streamController = StreamController<List<String>>();

  Stream<List<String>> get blogData => streamController.stream;

  int getWidgetNum() => contentWidgets.length;

  String getBlogURL() => memberData.blogURL[blogIndex];

  String getMemberName() => memberName;

  String getBlogTitle() => memberData.blogTitle[blogIndex];

  String getBlogDate() => memberData.blogDate[blogIndex];

  String getBlogTxt() => memberData.blogTxt[blogIndex];

  void createWidgetBlogHeader() {
    contentWidgets.clear();
    contentWidgets.add(SizedBox(height: 30));
    contentWidgets.add(Text(getBlogTitle(),
        style: TextStyle(fontSize: 19, color: Colors.lightBlue)));
    contentWidgets.add(SizedBox(height: 80));
  }

  void createWidgetBlogView(String data) {
    if (data.startsWith("<div dir=\"auto\">")) {
      if (data.startsWith("<div dir=\"auto\"><div>")) {
        blogImage(data);
      } else {
        contentWidgets.add(Text(
            (data == "<div dir=\"auto\"><br>") ? ' ' : data.substring(16)));
      }
    } else {
      blogImage(data);
    }
  }

  void blogImage(String data) {
    if (data.contains("img src")) {
      String imageUrl = "http://blog.nanabunnonijyuuni.com" +
          data.substring(data.indexOf("/"), data.indexOf("style=") - 2);
      contentWidgets.add(
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 30),
          child: Image.network(imageUrl),
        ),
      );
    }
  }

  Widget hogehoge(int index) {
    return contentWidgets[index];
  }

  BlogViewModel({String this.memberName, int this.blogIndex})
      : assert(blogIndex != null && memberName != null) {
    createWidgetBlogHeader();
    BlogDatailScreper();
  }

  void BlogDatailScreper() async {
    loadingFlag = false;
    final String baseURL = "http://blog.nanabunnonijyuuni.com";
    final webScraper = WebScraper(baseURL);

    //サムネ取得
    if (await webScraper.loadWebPage(memberData.blogURL[blogIndex]
        .replaceFirst("http://blog.nanabunnonijyuuni.com/", '/'))) {
      final String elements = webScraper.getPageContent();
//      elements.forEach((element) {
//        memberData.blogThumbnailPath.add(element['div'].toString());
//      }
//      );

//      //タイトル取得
//      elements.clear();
//      elements.addAll(
//          webScraper.getElement('div.blog-list__title > p.title', ['title']));
//      elements.forEach((element) {
//        _member.blogTitle.add(element['title'].toString());
//      });

      String hogehoge = elements.substring(
          elements.indexOf("blog_detail__main") + 20,
          elements.indexOf("<!--twitter-->"));
      List fugafuga = hogehoge.split("</div>");
      fugafuga.forEach((element) {
        createWidgetBlogView(element.toString());
      });
      pageIndex++;
      loadingFlag = true;
      streamController.sink.add(fugafuga);
    }
  }
}
