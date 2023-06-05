import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'expense.g.dart';

const uuid = Uuid();

final formatter = DateFormat('dd/MM/yyyy');

@HiveType(typeId: 1)
class Expense {
  Expense({
    required this.name,
    required this.amount,
    required this.price,
    required this.date,
  }) : id = uuid.v4();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int amount;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final DateTime date;

  String get formattedDate => formatter.format(date);
}
