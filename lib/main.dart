import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker_advance/screens/expense_list_screen.dart';

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

class ExpenseTrackerAdvance extends StatelessWidget {
  const ExpenseTrackerAdvance({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: ExpenseListScreen(),
      ),
    );
  }
}
