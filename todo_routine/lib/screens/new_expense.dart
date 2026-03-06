

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:todo_routine/models/expense.dart';
import 'package:todo_routine/screens/components/date_picker.dart';
import 'package:todo_routine/screens/widgets/android_show_dialog.dart';
import 'package:todo_routine/screens/widgets/ios_show_dialog.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense)
  onAddExpense; //this func need to pass a function with a custom class as a parameter

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _textControler =
      TextEditingController(); //adding Controller for saving user inputs
  final _amountControler = TextEditingController();

  DateTime? _selectedDate;

  Categories _selecteCategory = Categories.leisure;

  void _presentDatePicker() async {
    _selectedDate = await presentDatePicker(context);
    setState(() {});
  }

  void _setDialogAlert() {
    if (kIsWeb) { //comment on if use web
    // if (Platform.isAndroid) { // instead comment it
    
      showDialog(context: context, builder: (ctx) => AndroidShowDialog());
    } else {
      showDialog(context: context, builder: (ctx) => IosShowDialog());
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountControler.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_textControler.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _setDialogAlert();
      return;
    }

    widget.onAddExpense(
      //widget. property import function onAddExpense from Statefull class
      Expense(
        amount: enteredAmount,
        date: _selectedDate!,
        title: _textControler.text,
        category: _selecteCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // this flutter method for deleting Controllers in memory. Used only in State classes
    _textControler.dispose(); // free memory from Controllers
    _amountControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpase = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpase + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textControler,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("Title"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            controller: _amountControler,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text("Amount of expenses"),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _textControler,
                      maxLength: 50,
                      decoration: const InputDecoration(label: Text("Title")),
                    ),

                  const SizedBox(height: 16),

                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selecteCategory,
                          items:
                              Categories.values
                                  .map(
                                    (value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selecteCategory = value;
                            });
                          },
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'Date is not selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountControler,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text("Amount of expenses"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDate == null
                                      ? 'Date is not selected'
                                      : formatter.format(_selectedDate!),
                                ),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 16),

                  if (width >= 600)
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _selecteCategory,
                          items:
                              Categories.values
                                  .map(
                                    (value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selecteCategory = value;
                            });
                          },
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: _submitExpenseData,
                                child: const Text("Save Expense"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
