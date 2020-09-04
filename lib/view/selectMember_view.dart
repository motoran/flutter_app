import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/selectBlog_view.dart';
import 'package:flutterapp/view/selectBlog_viewmodel.dart';
import 'package:flutterapp/view/selectMember_viewmodel.dart';
import 'package:provider/provider.dart';

class SelectMemberView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("blog"),
        automaticallyImplyLeading: false,
      ),
      body: ChangeNotifierProvider<SelectMemberViewModel>(
        create: (_) => SelectMemberViewModel(),
        child: Consumer<SelectMemberViewModel>(
            builder: (context, SelectMemberViewModel value, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 16,
              crossAxisSpacing: 1,
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            scrollDirection: Axis.vertical,
            primary: false,
            padding: const EdgeInsets.all(5),
            itemCount: value.getMemberNum(),
            itemBuilder: (BuildContext context, int index) {
              return _memberButton(context, value, index);
            },
          );
        }),
      ),
    );
  }

  Widget _memberButton(
      BuildContext context, SelectMemberViewModel vm, int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 95,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(vm.getMemberImage(index)),
                )),
            child: Opacity(
              opacity: 0.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                                create: (_) => selectBlogViewModel(index: index),
                                child: selectBlogView(),
                              )));
                },
              ),
            ),
          ),
          Text(
            "${vm.getMemberName(index)}",
            style: TextStyle(fontSize: 12, color: Colors.lightBlue),
          ),
        ],
      ),
    );
  }
}
