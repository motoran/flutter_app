import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/blog_viewmodel.dart';
import 'package:provider/provider.dart';

class BlogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlogViewModel _vm = Provider.of<BlogViewModel>(context, listen: true);

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
            color: Colors.white70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
                  child: Container(
                    height: 100,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(vm.getBlogThumbnailPath(index)),
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
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          SizedBox.fromSize(size: Size.fromHeight(8)),
                          Text(
                            "${vm.getBlogDate(index)}",
                            style:
                                TextStyle(fontSize: 8, color: Colors.black54),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
