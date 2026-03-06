import 'package:flutter/material.dart';

Future<DateTime?> presentDatePicker(BuildContext context) async {
  final now = DateTime.now();
  final firstDate = DateTime(
    now.year - 1,
    now.month,
    now.day,
  ); //sets the range of start dates of one year
  final pickedDate = await showDatePicker(
    context: context, //return information about the date
    initialDate: now,
    firstDate: firstDate  ,
    lastDate: now,
  );
  return pickedDate;
}
