import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/member_data.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class selectBlogViewModel extends ChangeNotifier {
  final MemeberData _member = MemeberData();
  WebViewController webViewController;

  ScrollNotification _notification = null;

  final int index;
  int pageIndex = 0;
  bool loadingFlag = true;
  var streamController = StreamController<List<String>>();

  Stream<List<String>> get bloglPath => streamController.stream;

  int getBlogNum() => _member.blogThumbnailPath.length;

  String getBlogThumbnailPath(int index) => _member.blogThumbnailPath[index];

  String getBlogTitle(int index) => _member.blogTitle[index];

  String getBlogDate(int index) => _member.blogDate[index];

  String getBlogTxt(int index) => _member.blogTxt[index];

  String getMemberName() => _member.memberName[index];

  String getBlogUrl(int index) => _member.blogURL[index];

  void setNotification(var notification) {}

  //イけてない
  void ScrollNotificationIvent(ScrollNotification notification) {
    _notification = notification;
    if (loadingFlag) {
      if (_notification.metrics.extentAfter == 0) {
        BlogListScreper();
      }
    }
  }

  selectBlogViewModel({int this.index}) : assert(index != null) {
    clearMemdata();
    BlogListScreper();
  }

  void clearMemdata() {
    _member.blogThumbnailPath.clear();
    _member.blogTitle.clear();
    _member.blogDate.clear();
    _member.blogTxt.clear();
    _member.blogURL.clear();
    pageIndex = 0;
  }

  void BlogListScreper() async {
    loadingFlag = false;
    String page = (pageIndex == 0) ? "" : "&page=" + pageIndex.toString();
    final String baseURL = "http://blog.nanabunnonijyuuni.com";
    final webScraper = WebScraper(baseURL);

    //サムネ取得
    if (await webScraper.loadWebPage(_member.memberBlog[index]
            .replaceFirst("http://blog.nanabunnonijyuuni.com/", '/') +
        page)) {
      final List<Map<String, dynamic>> elements =
          webScraper.getElement('div.blog-list__thumb > img', ['style']);
      elements.forEach((element) {
        _member.blogThumbnailPath.add(baseURL +
            PerseBlogbThumbnailPath(element['attributes']['style'].toString()));
      });

      //タイトル取得
      elements.clear();
      elements.addAll(
          webScraper.getElement('div.blog-list__title > p.title', ['title']));
      elements.forEach((element) {
        _member.blogTitle.add(element['title'].toString());
      });

      //ライター取得
      elements.clear();
      elements.addAll(
          webScraper.getElement('div.blog-list__title > p.date', ['date']));
      elements.forEach((element) {
        _member.blogDate.add(element['title'].toString());
      });

      //テキスト取得
      elements.clear();
      elements
          .addAll(webScraper.getElement('div.blog-list__txt > p.txt', ['txt']));
      elements.forEach((element) {
        _member.blogTxt.add(element['title'].toString());
      });

      //テキスト取得
      elements.clear();
      elements.addAll(
          webScraper.getElement('div.blog-list__more > p.more > a', ['href']));
      elements.forEach((element) {
        _member.blogURL.add(baseURL + element['attributes']['href'].toString());
      });
    }

//    if (await webScraper.loadWebPage(_member.memberBlog[index]
//            .replaceFirst("http://blog.nanabunnonijyuuni.com/", '/') +
//        "&page=2")) {
//      final List<Map<String, dynamic>> elements =
//          webScraper.getElement('div.blog-list__thumb > img', ['style']);
//      elements.forEach((element) {
//        _member.blogThumbnailPath.add(baseURL +
//            PerseBlogbThumbnailPath(element['attributes']['style'].toString()));
//      });

    pageIndex++;
    loadingFlag = true;
    streamController.sink.add(_member.blogThumbnailPath);
  }
}
//}

String PerseBlogbThumbnailPath(String data) {
  //　最初のいらない文字列を置換する 空文字 ( To == '' )で置換できないため、一文字ずらしている
  data = data.replaceFirst("background-image:url(/", '/');
  //末尾の2文字もいらないので切り出し
  return data.substring(0, data.length - 2);
}

//http://blog.nanabunnonijyuuni.com/images/30/84d/8f51827fd9070f52aee6d024ef3ee.jpg
//"style" -> "background-image:url(/images/30/ca2/e0742c78bb90416d3e4277e0447cb.jpg);"
//"style" -> "background-image:url(/files/4/nanabunnonijyuuni/pc/img/blog/noimage.jpg);"
// files/4/nanabunnonijyuuni/pc/img/blog/list_thumb.png
