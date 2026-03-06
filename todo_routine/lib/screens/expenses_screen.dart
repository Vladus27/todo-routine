import 'package:flutter/material.dart';

import 'package:todo_routine/models/expense.dart';
import 'package:todo_routine/screens/chart/chart.dart';
import 'package:todo_routine/screens/expenses_list/expenses_list.dart';
import 'package:todo_routine/screens/new_expense.dart';
import 'package:todo_routine/services/expenses_storage.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> _expensesList = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final loadedExpenses = await ExpensesStorage.loadExpenses();
    setState(() {
      _expensesList = loadedExpenses;
    });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
    ExpensesStorage.saveExpenses(_expensesList);
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);

    setState(() {
      _expensesList.remove(expense);
    });
    ExpensesStorage.saveExpenses(_expensesList);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
            ExpensesStorage.saveExpenses(_expensesList);
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some!"),
    );
    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expensesList,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Manage Expenses"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _expensesList),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: Chart(expenses: _expensesList)),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }
}
