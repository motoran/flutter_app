import 'package:flutter/cupertino.dart';
import 'package:flutterapp/member_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogViewModel extends ChangeNotifier {
  final MemeberData _member = MemeberData();
  WebViewController webViewController;

  final int index;

  String getBlogURL() => _member.memberBlog[index];

  String getMemberName() => _member.memberName[index];

  BlogViewModel({int this.index}) : assert(index != null) {}
}
