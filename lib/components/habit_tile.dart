// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitname;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onSetting;
  final Function(BuildContext)? onDelete;

  const HabitTile({
    Key? key,
    required this.habitname,
    required this.habitCompleted,
    required this.onChanged,
    required this.onSetting,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //settings
            SlidableAction(
              onPressed: onSetting,
              icon: Icons.settings,
              backgroundColor: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            //deleteing
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade700,
              borderRadius: BorderRadius.circular(8),
            )
          ]
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(  
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Checkbox(value: habitCompleted, onChanged: onChanged),
              Text(
                habitname,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
