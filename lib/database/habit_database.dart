import 'package:hive_flutter/adapters.dart';

class HabitDB{
  //list of habits
  List habitList = [];

  // reference the hive box
  final box = Hive.box('mybox');

  //load initial data
  void loadInitialData(){
    habitList = [
      ['codexharoon',false],
      ['visited',false],
    ];
  }

  //load data from hive
  void loadData(){
    habitList = box.get('habitlist');
  }

  //update database
  void updateDatabase(){
    box.put('habitlist', habitList);
  }
}