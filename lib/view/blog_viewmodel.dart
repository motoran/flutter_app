import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/member_data.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogViewModel extends ChangeNotifier {
  WebViewController webViewController;
  final MemberData memberData = MemberData();
  final String memberName;
  final int index;

  int pageIndex = 0;
  bool loadingFlag = true;
  var streamController = StreamController<List<String>>();

  Stream<List<String>> get bloglPath => streamController.stream;

  List<String> blogDataText = List<String>();
  List<String> blogDataImage = List<String>();
  List<String> blogData = List<String>();

  String getBlogURL() => memberData.blogURL[index];

  String getMemberName() => memberName;

//  List<Widget> hoge(){
//    var contentWidgets = List<Widget>();
//
//
//  }

  BlogViewModel({String this.memberName, int this.index})
      : assert(index != null && memberName != null) {
  }

//  void BlogDataScreper() async {
//    loadingFlag = false;
//    final String baseURL = "http://blog.nanabunnonijyuuni.com";
//    final webScraper = WebScraper(baseURL);
//
//    //サムネ取得
//    if (await webScraper.loadWebPage(memberData.memberBlog[index]
//        .replaceFirst("http://blog.nanabunnonijyuuni.com/", '/') +
//        page)) {
//      final List<Map<String, dynamic>> elements =
//      webScraper.getElement('div.blog-list__thumb > img', ['style']);
//      elements.forEach((element) {
//        memberData.blogThumbnailPath.add(baseURL +
//            PerseBlogbThumbnailPath(element['attributes']['style'].toString()));
//      });
//
//      //タイトル取得
//      elements.clear();
//      elements.addAll(
//          webScraper.getElement('div.blog-list__title > p.title', ['title']));
//      elements.forEach((element) {
//        _member.blogTitle.add(element['title'].toString());
//      });
//
//    pageIndex++;
//    loadingFlag = true;
//    streamController.sink.add(memberData.blogThumbnailPath);
//  }
}
