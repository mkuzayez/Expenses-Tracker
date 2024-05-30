// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import './models/expense_class.dart';
import './expense_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class expense_list extends StatelessWidget {
  const expense_list(this.regestered_expenses, this.deleteExpense, {super.key});

  final List<Expense> regestered_expenses;
  final Function(Expense expense) deleteExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: regestered_expenses.length,
      itemBuilder: (BuildContext ctx, int index) => Slidable(
        key: ValueKey(ctx),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            Expanded(
              child: Card(
                // color: const Color.fromARGB(255, 120, 0, 0),
                child: Container(
                  margin: const EdgeInsets.all(9.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: const ButtonStyle(
                        // iconColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: (){deleteExpense(regestered_expenses[index]);},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete),
                          Text(
                            "Delete",
                            // style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        child: expense_item(
          regestered_expenses[index],
          key: ValueKey(ctx),
        ),
      ),
    );
  }
}
