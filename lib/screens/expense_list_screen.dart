import 'package:expense_tracker_advance/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_tracker_advance/screens/add_expense_screen.dart';
import 'package:expense_tracker_advance/widgets/expense_item.dart';

class ExpenseListScreen extends ConsumerStatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  ConsumerState<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends ConsumerState<ExpenseListScreen> {
  late final Future<void> expenseList;

  @override
  void initState() {
    expenseList = ref.read(expenseProvider.notifier).loadExpense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void toAddScreen(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddExpense(),
        ),
      );
    }

    final expenseList = ref.watch(expenseProvider);

    var totalPrice = 0.0;

    for (final expense in expenseList) {
      totalPrice += expense.price;
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    child: FloatingActionButton(
                      onPressed: () {
                        toAddScreen(context);
                      },
                      backgroundColor: Colors.black,
                      mini: true,
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Spent this week',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 35, color: Colors.grey),
                      text: '\$ ',
                      children: [
                        TextSpan(
                          text: '295.96',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  ListTile(
                    leading: const Text(''),
                    title: const Text('Today'),
                    trailing: Container(
                      margin: const EdgeInsets.only(top: 7),
                      child: Text(totalPrice.toString()),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: FractionallySizedBox(
                      widthFactor: 0.86,
                      child: Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  if (expenseList.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: expenseList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(expenseList[index].id),
                            onDismissed: (direction) {
                              setState(() {
                                ref
                                    .watch(expenseProvider.notifier)
                                    .removeExpense(expenseList[index]);
                              });
                            },
                            child: ExpenseItem(
                              name: expenseList[index].name,
                              amount: expenseList[index].amount,
                              price: expenseList[index].price,
                              date: expenseList[index].formattedDate,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
