import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeViewModel _vm = Provider.of<HomeViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('BINGO GAME'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Text(""),
      ),
    );
  }
}
