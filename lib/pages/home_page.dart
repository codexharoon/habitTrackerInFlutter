import 'package:flutter/material.dart';
import 'package:habit_tracker/components/custom_dialog.dart';
import 'package:habit_tracker/components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List habitList = [
    ['codexharoon',false],
    ['visited',false],
  ];

  // text editing controller
  final controller = TextEditingController();

  //tap on checkbox 
  void checkBoxTapped(bool? value, int index){
    setState(() {
      habitList[index][1] = !habitList[index][1]; 
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
      habitList.add([controller.text,false]);
      controller.clear();
    });
    onCancel();
  }


  // on delete
  void onDelete(_,int index){
    setState(() {
      habitList.removeAt(index);
    });
  }

  // on settings
  void onSettings(_,int index){
    showDialog(
      context: context,
      builder: (_) => CustomDialog(onCancel: onCancel, onSave: () => updateExistingHabit(index), controller: controller,hintText: "update '${habitList[index][0]}'"),
    );
  }

  //update existing habit
  void updateExistingHabit(int index){
    setState(() {
      habitList[index][0] = controller.text;
      controller.clear();
    });
    onCancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView.builder(  
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          //habit tiles
          return HabitTile(
            habitname: habitList[index][0],
            habitCompleted: habitList[index][1],
            onChanged: (value) => checkBoxTapped(value,index),
            onSetting: (context) => onSettings(context,index),
            onDelete: (context) => onDelete(context,index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(  
        onPressed: () {
          createNewHabit();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}