import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/blog_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlogViewModel _vm =
        Provider.of<BlogViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(_vm.getMemberName() + 'のブログ'),
        automaticallyImplyLeading: false,
      ),
      body: WebView(
        initialUrl: _vm.getBlogURL(),
        javascriptMode: JavascriptMode.unrestricted,
//        onWebViewCreated: (WebViewController controller) {
//          _vm.webViewController = controller;
//        },
      ),
    );
  }
}
