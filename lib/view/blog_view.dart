import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/blog_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlogViewModel _vm = Provider.of<BlogViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("blog"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: StreamBuilder<List<String>>(
          stream: _vm.bloglPath,
          builder: (_, snapshot) {
            if (snapshot.data == null || snapshot.data.isEmpty) {
              return Container();
            }
            return ListView.builder(
                itemCount: _vm.getBlogNum(),
                itemBuilder: (context, int index) {
                  return _memberButton(context, index);
                });
          },
        ),
      ),
    );
  }

  Widget _memberButton(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Consumer<BlogViewModel>(
        builder: (context, BlogViewModel vm, Widget _) {
          return Card(
            elevation: 2.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(vm.getBlogThumbnailPath(index)),
                        )),
                  ),
                ),
                Flexible(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${vm.getBlogTitle(index)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 15, color: Colors.lightBlue),
                        ),
                        Text(
                          "${vm.getBlogWriter(index)}",
                          style: TextStyle(fontSize: 10, color: Colors.black26),
                        )
                      ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
