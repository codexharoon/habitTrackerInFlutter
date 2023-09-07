import 'package:flutter/material.dart';
import 'package:habit_tracker/components/custom_dialog.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/monthly_summary.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _habitDB = HabitDB();

  // refernece the hive box
  final _box = Hive.box('mybox');


  //whenever app first time launch
  @override
  void initState() {

    if(_box.get('habitlist') == null){
      _habitDB.loadInitialData();
    }
    else{
      _habitDB.loadData();
    }


    super.initState();
  }

  // text editing controller
  final controller = TextEditingController();

  //tap on checkbox 
  void checkBoxTapped(bool? value, int index){
    setState(() {
      _habitDB.habitList[index][1] = !_habitDB.habitList[index][1]; 
      _habitDB.updateDatabase();
    });
  }

  // create new habit
  void createNewHabit(){
    //show dialog
    showDialog(context: context, builder: (_) => CustomDialog(onCancel: onCancel,onSave: onSave,controller: controller,hintText: 'Type Habit name',));
  }

  //on canel button
  void onCancel(){
    Navigator.of(context).pop();
  }

  //on save button
  void onSave(){
    setState(() {
      _habitDB.habitList.add([controller.text,false]);
      _habitDB.updateDatabase();
      controller.clear();
    });
    onCancel();
  }


  // on delete
  void onDelete(_,int index){
    setState(() {
      _habitDB.habitList.removeAt(index);
      _habitDB.updateDatabase();
    });
  }

  // on settings
  void onSettings(_,int index){
    showDialog(
      context: context,
      builder: (_) => CustomDialog(onCancel: onCancel, onSave: () => updateExistingHabit(index), controller: controller,hintText: "update '${_habitDB.habitList[index][0]}'"),
    );
  }

  //update existing habit
  void updateExistingHabit(int index){
    setState(() {
      _habitDB.habitList[index][0] = controller.text;
      _habitDB.updateDatabase();
      controller.clear();
    });
    onCancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            // heat map monthly summary
            MonthlySummary(startDate: _box.get('startdate'), datasets: _habitDB.datasets),
    
            //list of habits
            ListView.builder(  
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _habitDB.habitList.length,
              itemBuilder: (context, index) {
                //habit tiles
                return HabitTile(
                  habitname: _habitDB.habitList[index][0],
                  habitCompleted: _habitDB.habitList[index][1],
                  onChanged: (value) => checkBoxTapped(value,index),
                  onSetting: (context) => onSettings(context,index),
                  onDelete: (context) => onDelete(context,index),
                );
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(  
          backgroundColor: Colors.grey[900],
          onPressed: () {
            createNewHabit();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}