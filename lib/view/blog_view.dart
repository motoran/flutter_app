import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'blog_viewmodel.dart';

class BlogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlogViewModel _vm = Provider.of<BlogViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text( "${_vm.getMemberName()}" + ' の blog'),
        automaticallyImplyLeading: false,
      ),
      body: WebView(
        initialUrl: _vm.getBlogURL(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _vm.webViewController = controller;
        },
      ),
    );
  }
}
