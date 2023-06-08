import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:expense_tracker_advance/models/expense.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  final thisYear = DateTime.now().year;
  final thisMonth  = DateTime.now().month;
  final DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var totalPrice = 0.0;

  bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      return isLeapYear(year) ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }

  DateTime get startDayOfWeek => today.subtract(
        Duration(
          days: today.weekday - 1,
        ),
      );

  DateTime get endDayOfWeek => today.add(
        Duration(
          days: DateTime.daysPerWeek - today.weekday,
        ),
      );

  DateTime get startDayOfMonth =>
      DateTime(thisYear, thisMonth);
  DateTime get endDayOfMonth =>
      DateTime(thisYear, thisMonth, getDaysInMonth(thisYear, thisMonth));

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

  List<double> getListPriceByDayOfWeek() {
    totalPrice = 0.0;
    List<double> listPrice = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    for (var item in state) {
      if (item.date.compareTo(startDayOfWeek) >= 0 &&
          item.date.compareTo(endDayOfWeek) <= 0) {
        listPrice[item.date.weekday - 1] += item.price;
        totalPrice += item.price;
      }
    }

    return listPrice;
  }

  List<double> getListPriceByMonth() {
    totalPrice = 0.0;
    List<double> listPrice = List.filled(getDaysInMonth(thisYear, thisMonth), 0.0);

    for (var item in state) {
      if (item.date.compareTo(startDayOfMonth) >= 0 &&
          item.date.compareTo(endDayOfMonth) <= 0) {
        listPrice[item.date.day - 1] += item.price;
        totalPrice += item.price;
      }
    }

    return listPrice;
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
  (ref) => ExpenseNotifier(),
);
