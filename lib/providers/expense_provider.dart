import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:expense_tracker_advance/models/expense.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  Future<void> loadExpense() async {
    var boxExpense = await Hive.openBox<Expense>('expenseBox');
    for (final expense in boxExpense.values) {
      state = [...state, expense];
    }
  }

  void addExpense(Expense expense) async {
    var boxExpense = await Hive.openBox<Expense>('expenseBox');
    boxExpense.put(
      expense.id,
      Expense(
        name: expense.name,
        amount: expense.amount,
        price: expense.price,
        date: expense.date,
      ),
    );

    state = [...state, expense];
  }

  void removeExpense(Expense expense) async {
    var boxExpense = await Hive.openBox<Expense>('expenseBox');
    boxExpense.delete(expense.id);
    state = state.where((item) => item.id != expense.id).toList();
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
  (ref) => ExpenseNotifier(),
);
