import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_tracker_advance/providers/expense_provider.dart';
import 'package:expense_tracker_advance/screens/expense_list_screen.dart';
import 'package:expense_tracker_advance/screens/statistic_screen.dart';
import 'package:expense_tracker_advance/screens/add_expense_screen.dart';
import 'package:expense_tracker_advance/models/expense.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  runApp(
    const ProviderScope(
      child: ExpenseTrackerAdvance(),
    ),
  );
}

class ExpenseTrackerAdvance extends ConsumerStatefulWidget {
  const ExpenseTrackerAdvance({super.key});

  @override
 ConsumerState<ExpenseTrackerAdvance> createState() => _ExpenseTrackerAdvanceState();
}

class _ExpenseTrackerAdvanceState extends ConsumerState<ExpenseTrackerAdvance> {
  late final Future<void> loadExpense;

  int _currentIndex = 0;
  List<Widget> body = const [
    ExpenseListScreen(),
    StatisticScreen(),
    AddExpenseScreen(),
  ];

  @override
  void initState() {
    loadExpense = ref.read(expenseProvider.notifier).loadExpense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: body[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Expense',
                icon: Icon(Icons.wallet),
              ),
              BottomNavigationBarItem(
                label: 'Statistic',
                icon: Icon(Icons.bar_chart),
              ),
              BottomNavigationBarItem(
                label: 'Setting',
                icon: Icon(Icons.settings),
              ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }
}
