import 'package:flutter/material.dart';
import 'package:habit_tracker/components/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final Function()? onCancel;
  final Function()? onSave;
  final dynamic controller;
  final String hintText;

  const CustomDialog(
    {
      super.key,
      required this.onCancel,
      required this.onSave,
      required this.controller,
      required this.hintText,
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AlertDialog(
            backgroundColor: Colors.grey[900],
            content: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(  
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                hintText: hintText,
                hintStyle: TextStyle(  
                  color: Colors.grey[600],
                )
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(onPressed: onCancel, buttonName: 'Cancel'),
                  const SizedBox(width: 7,),
                  CustomButton(onPressed: onSave, buttonName: 'Save'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}