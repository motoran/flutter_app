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
        title: Text("${_vm.getMemberName()}" + ' の blog'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: StreamBuilder<List<String>>(
          stream: _vm.blogData,
          builder: (_, snapshot) {
            if (snapshot.data == null || snapshot.data.isEmpty) {
              return Container(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }
            return Container(
              margin: EdgeInsets.only(right: 30, left: 30, top: 15, bottom: 15),
              child: ListView.builder(
                  itemCount: _vm.getWidgetNum(),
                  itemBuilder: (context, int index) {
                    return _vm.hogehoge(index);
                  }),
            );
          },
        ),
      ),
    );
  }
}
