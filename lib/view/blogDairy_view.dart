import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'blogDairy_viewmodel.dart';

class BlogDailyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlogDailyViewModel _vm = Provider.of<BlogDailyViewModel>(context, listen: true);

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
