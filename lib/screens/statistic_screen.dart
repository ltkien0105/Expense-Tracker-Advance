import 'package:expense_tracker_advance/widgets/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_tracker_advance/providers/expense_provider.dart';

class StatisticScreen extends ConsumerStatefulWidget {
  const StatisticScreen({super.key});

  @override
  ConsumerState<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends ConsumerState<StatisticScreen> {
  bool isWeek = true;
  
  @override
  Widget build(BuildContext context) {
    List<double> expensePrice;
    if (isWeek) {
      expensePrice =
          ref.watch(expenseProvider.notifier).getListPriceByDayOfWeek();
    } else {
      expensePrice = ref.watch(expenseProvider.notifier).getListPriceByMonth();
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
                      onPressed: () {},
                      backgroundColor: Colors.black,
                      mini: true,
                      child: const Icon(Icons.more_horiz),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$ ${ref.watch(expenseProvider.notifier).totalPrice}',
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isWeek
                          ? 'Total spent this week'
                          : 'Total spent this month',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: expensePrice.isEmpty
                    ? const Center(
                        child: Text(
                          'No data, please add data to display the graph',
                        ),
                      )
                    : BarGraph(
                        summary: expensePrice,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isWeek = true;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Text(
                            'Week',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isWeek = false;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Text(
                            'Month',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => const Text('data'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
