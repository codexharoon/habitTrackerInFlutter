import 'package:habit_tracker/datetime/date_time.dart';
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

    box.put('startdate', todaysDateFormatted());
  }

  //load data from hive
  void loadData(){

    // if its new day, get habit list from database
    if(box.get(todaysDateFormatted()) == null){
      habitList = box.get('habitlist');

      // its a new day set all habit to false
      for(int i=0; i<habitList.length; i++){
        habitList[i][0] = false;
      }
    }
    // not a new day, load todays list
    else{
      habitList = box.get(todaysDateFormatted());
    }
  }

  //update database
  void updateDatabase(){
    box.put('habitlist', habitList);

    //update todays entry
    box.put(todaysDateFormatted(), habitList);
  }
}