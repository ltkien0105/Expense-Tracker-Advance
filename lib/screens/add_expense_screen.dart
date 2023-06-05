import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_tracker_advance/models/expense.dart';
import 'package:expense_tracker_advance/providers/expense_provider.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({super.key});

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  DateFormat formattedDate = DateFormat('dd/MM/yyyy');
  var now = DateTime.now();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();

  String? name;
  int? amount;
  double? price;
  DateTime? _selectedDate;

  bool _isValidName = true;
  bool _isValidAmount = true;
  bool _isValidPrice = true;

  bool _isValidate() {
    if (_nameController.text.isEmpty) {
      setState(() {
        _isValidName = false;
      });
    } else {
      name = _nameController.text;
    }

    if (_amountController.text.isEmpty ||
        int.tryParse(_amountController.text) == null) {
      setState(() {
        _isValidAmount = false;
      });
    } else {
      amount = int.parse(_amountController.text);
    }

    if (_priceController.text.isEmpty ||
        double.tryParse(_priceController.text) == null) {
      setState(() {
        _isValidPrice = false;
      });
    } else {
      price = double.parse(_priceController.text);
    }

    if (!_isValidName || !_isValidName || !_isValidName) {
      return false;
    }

    _selectedDate ??= now;

    return true;
  }

  void _onSave(List<Expense> expenseList) {
    if (_isValidate()) {
      ref.watch(expenseProvider.notifier).addExpense(
            Expense(
              name: name!,
              amount: amount!,
              price: price!,
              date: _selectedDate!,
            ),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add expense successfully!'),
        ),
      );

      setState(() {
        _nameController.text = '';
        _amountController.text = '';
        _priceController.text = '';
      });
      // print(expenseList.length);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all field with correct format!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Expense> expenseList = ref.watch(expenseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _nameController,
                    onChanged: (value) {
                      setState(() {
                        _isValidName = true;
                      });
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Name',
                      errorText:
                          !_isValidName ? 'This field isn\'t empty' : null,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _amountController,
                    onChanged: (value) {
                      setState(() {
                        _isValidAmount = true;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Amount',
                      errorText: !_isValidAmount
                          ? 'This field must have a interger number'
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    onChanged: (value) {
                      setState(() {
                        _isValidPrice = true;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Price',
                      errorText: !_isValidPrice
                          ? 'This field must have a number'
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          // height: double.infinity,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: _selectedDate == null
                              ? Text(
                                  formattedDate.format(now).toString(),
                                )
                              : Text(formattedDate
                                  .format(_selectedDate!)
                                  .toString()),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () async {
                            final DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: DateTime(now.year - 1),
                              lastDate: now,
                            );

                            if (dateTime != null) {
                              setState(() {
                                _selectedDate = dateTime;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _onSave(expenseList);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
