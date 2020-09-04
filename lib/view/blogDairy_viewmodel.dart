import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDailyViewModel extends ChangeNotifier {
  WebViewController webViewController;

  final String memName;
  final String blogURL;

  String getBlogURL() => blogURL;

  String getMemberName() => memName;

  BlogDailyViewModel({String this.memName, String this.blogURL})
      : assert(memName != null && blogURL != null) {}
}
