import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/selectBlog_viewmodel.dart';
import 'package:provider/provider.dart';

import 'blog_view.dart';
import 'blog_viewmodel.dart';

class selectBlogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectBlogViewModel _vm =
        Provider.of<selectBlogViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("${_vm.getMemberName()}" + " の blog"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: StreamBuilder<List<String>>(
          stream: _vm.bloglPath,
          builder: (_, snapshot) {
            if (snapshot.data == null || snapshot.data.isEmpty) {
              return Container(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                // スクロールイベントのハンドリング
                _vm.hogeScrollNotification(notification);
                return false;
              },
              child: ListView.builder(
                  itemCount: _vm.getBlogNum(),
                  itemBuilder: (context, int index) {
                    return _memberButton(context, index);
                  }),
            );
          },
        ),
      ),
    );
  }

  Widget _memberButton(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Consumer<selectBlogViewModel>(
        builder: (context, selectBlogViewModel vm, Widget _) {
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => BlogViewModel(
                          memName: vm.getMemberName(),
                          blogURL: vm.getBlogUrl(index)),
                      child: BlogView(),
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 2.0,
                color: Colors.white70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          right: 10, left: 10, top: 15, bottom: 15),
                      child: Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  NetworkImage(vm.getBlogThumbnailPath(index)),
                            )),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(right: 10, top: 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${vm.getBlogTitle(index)}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.lightBlue),
                              ),
                              SizedBox.fromSize(size: Size.fromHeight(8)),
                              Text(
                                "${vm.getBlogTxt(index)}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              SizedBox.fromSize(size: Size.fromHeight(8)),
                              Text(
                                "${vm.getBlogDate(index)}",
                                style: TextStyle(
                                    fontSize: 8, color: Colors.black54),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ); // スクロール可能なウィジェット
        },
      ),
    );
  }
}
