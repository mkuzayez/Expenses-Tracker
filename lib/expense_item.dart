import 'package:flutter/material.dart';
import './models/expense_class.dart';

// ignore: camel_case_types
class expense_item extends StatelessWidget {
  const expense_item(this.expense, {super.key});
  final Expense expense;



  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(9.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '\$ ${expense.amount.toString()}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcones[expense.category]),
                  const SizedBox(width: 6),
                  Text(
                    expense.formatedDate.toString(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
