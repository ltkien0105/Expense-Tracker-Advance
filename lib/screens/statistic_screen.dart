import 'package:flutter/material.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
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
                  children: const [
                    Text(
                      '\$295.95',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Total spent this week',
                      style: TextStyle(
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
                color: Colors.black,
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) => const ExpenseItem(),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
