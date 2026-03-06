import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); // from intl package makes data more human-readable 


const uuid = Uuid();

enum Categories {food, work, travel, leisure} // enum is like a custom Class with String values between the curly brackets

const categoryIcons = {
Categories.food: Icons.lunch_dining, // we mark a value throw the dot. It`s like unpacking variable
Categories.work: Icons.work,
Categories.travel: Icons.flight,
Categories.leisure: Icons.weekend,

};



class Expense {
  Expense({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
    String? id, // Додано сюди!
  }) : id = id ?? uuid.v4(); // Якщо id не передали — згенерується автоматично

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formatedData {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}

// class Expense{
// Expense({
//   required this.amount,
//   required this.date,
//   required this.title,
//   required this.category,
// }) : id = uuid.v4(); //  initialized the id variable when constructor is called. This is initializer list!

//   final String id;
//   final String title;
//   final double amount;
//   final DateTime date;
//   final Categories category;


// String get formatedData{ // it`s a getter structure. We safe the value object in formatedData variable. Throw the dot we can use this values
//    return DateFormat('dd/MM/yyyy').format(date); //format method return String containing the formatted version of data
// }


// }



class ExpenseBucket{
  const ExpenseBucket({required this.category, required this.expenses});

  final Categories category;
  final List<Expense> expenses ;

ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) : expenses = allExpenses.where((expense) => expense.category == category).toList();

  double get totalExpenses{ // use getter for store all propeties for expenses
    double sum = 0;
    for(final expense in expenses){ // for every element of expenses we store in expense var
      sum += expense.amount;
    }
    
    return sum;
  }
}