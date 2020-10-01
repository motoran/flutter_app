//シングルトンで扱う
//ちゃんと書くならリネームする
class BingoData {

  static final BingoData _instance = BingoData._internal();

  factory BingoData() => _instance;

  BingoData._internal();

  List<int> numData = List<int>();

  int getBingoNum(int index) => numData[index];

  void addNum(int num){
    numData.add(num);
  }

}