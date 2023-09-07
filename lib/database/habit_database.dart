import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/adapters.dart';

class HabitDB{
  //list of habits
  List habitList = [];

  //heat map dataset
  Map<DateTime, int> datasets = {};

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


    calculateHabitPercentage();
    loadHeatMap();
  }

  // -------------------heat map requried methods---------------

  //calculate habit percentages
  void calculateHabitPercentage(){
    int countCompleted = 0;
    for(int i=0; i<habitList.length; i++){
      if(habitList[i][1] == true){
        countCompleted++;
      }
    }

    String percentage = habitList.isEmpty ? '0.0' : (countCompleted / habitList.length).toString();

    box.put("percentage_${todaysDateFormatted()}", percentage);
  }


  // load heat map
  void loadHeatMap(){
    DateTime startDate = createDateTimeObject(box.get('startdate'));


    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for(int i=0; i<daysInBetween+1; i++){

      String yyyymmdd = convertDateTimeToString(startDate.add(Duration(days: i)));

      double strengthAsPercent = double.parse(
        box.get("percentage_$yyyymmdd") ?? "0.0",
      );


      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year,month,day) : (10 * strengthAsPercent).toInt(),
      };

      datasets.addEntries(percentForEachDay.entries);
    }

  }

}