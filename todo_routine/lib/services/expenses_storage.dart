import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_routine/models/expense.dart';

class ExpensesStorage {
  static const String _key = 'expenses_data';

  // save list of expenses in SharedPreferences
  static Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = expenses.map((expense) {
      return {
        'id': expense.id,
        'title': expense.title,
        'amount': expense.amount,
        'date': expense.date.toIso8601String(),
        'category': expense.category.name,
      };
    }).toList();

    final jsonString = json.encode(jsonList);
    await prefs.setString(_key, jsonString);
  }

  /// load list of expenses from SharedPreferences
  static Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List<dynamic> decodedList = json.decode(jsonString);

    return decodedList.map<Expense>((item) {
      return Expense(
        id: item['id'],
        title: item['title'],
        amount: item['amount'],
        date: DateTime.parse(item['date']),
        category: Categories.values.firstWhere((cat) => cat.name == item['category']),
      );
    }).toList();
  }
}
