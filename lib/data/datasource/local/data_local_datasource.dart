
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DataLocalDataSourceImpl{
  DataLocalDataSourceImpl(){}

  void openBox() async {
    Hive.initFlutter();
    await Hive.openBox('userdata');
  }
  
  Box getDataLocal(){
    final box = Hive.box('userdata');
    return box;
  }
}