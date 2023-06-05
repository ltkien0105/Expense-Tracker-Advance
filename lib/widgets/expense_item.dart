import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final String name;
  final int amount;
  final double price;
  final String date;
  const ExpenseItem(
      {super.key,
      required this.name,
      required this.amount,
      required this.price,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.account_balance_wallet,
            color: Colors.black,
            size: 35,
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('Amount: ${amount.toString()}'),
          trailing: Container(
            margin: const EdgeInsets.only(top: 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  price.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
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
      ],
    );
  }
}
