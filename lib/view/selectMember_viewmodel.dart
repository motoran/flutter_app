import 'package:flutter/cupertino.dart';
import 'package:flutterapp/member_data.dart';

class SelectMemberViewModel extends ChangeNotifier {
  final MemeberData _member = MemeberData();

  int getMemberNum() => _member.memberName.length;

  String getMemberName(int index) => _member.memberName[index];

  String getMemberImage(int index) => _member.memberImage[index];

  SelectMemberViewModel() {}
}
