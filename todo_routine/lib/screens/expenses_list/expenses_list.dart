import 'package:flutter/material.dart';
import 'package:todo_routine/models/expense.dart';
import 'package:todo_routine/screens/expenses_list/expenses_item.dart';



class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        //remove elements by swaps

        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),

        key: ValueKey(
            expenses[index]), // needs for identify the right object for remove
        onDismissed: (direction) {
          // set the direction because of needed type void Funcrion(DismissDirection)
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
