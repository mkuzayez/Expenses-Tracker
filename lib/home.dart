// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:the_expenses_tracker_v2/add_expense.dart';
import './models/expense_class.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'expense_list.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  // ignore: unused_field
  final List<Expense> _registered_expenses = [
    Expense(
      title: "title",
      category: Category.other,
      amount: 3.0,
      date: DateTime.now(),
    ),
    Expense(
      title: "X",
      category: Category.food,
      amount: 66.0,
      date: DateTime.now(),
    ),
    Expense(
      title: "X",
      category: Category.work,
      amount: 66.0,
      date: DateTime.now(),
    ),
    Expense(
      title: "X",
      category: Category.travel,
      amount: 66.0,
      date: DateTime.now(),
    ),
    Expense(
      title: "X",
      category: Category.leisure,
      amount: 66.0,
      date: DateTime.now(),
    ),
  ];

  Map<Category, double> exp = {
    Category.food: 0,
    Category.leisure: 0,
    Category.travel: 0,
    Category.other: 0,
    Category.work: 0,
  };
  void calculate() {
    setState(
      () {
        for (var key in exp.keys) {
          exp[key] = 0;
        }

        for (final expense in _registered_expenses) {
          exp[expense.category] = (exp[expense.category] ?? 0) + expense.amount;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    calculate();
  }

  void submitData(Expense expense) {
    setState(
      () {
        _registered_expenses.add(expense);
        calculate();
        Navigator.pop(context);
      },
    );
  }

  void deleteExpense(Expense expense) {
    setState(
      () {
        int idx = _registered_expenses.indexOf(expense);
        _registered_expenses.removeAt(idx);
        calculate();

        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Undo delete"),
            duration: const Duration(seconds: 3, milliseconds: 0),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                setState(
                  () {
                    _registered_expenses.insert(idx, expense);
                    calculate();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    Widget screenWidget = const Center(
      child: Text('No expenses found.'),
    );
    if (_registered_expenses.isNotEmpty) {
      screenWidget = width < 600
          ? Column(
              children: [
                SfCircularChart(
                  series: [
                    PieSeries(
                      dataSource: exp.entries.toList(),
                      xValueMapper: (entry, _) => entry.key.toString(),
                      yValueMapper: (entry, _) => entry.value,
                      name: exp.entries.toString(),
                      animationDuration: 1200,
                      explode: true,
                    ),
                  ],
                ),
                Expanded(
                  child: expense_list(_registered_expenses, deleteExpense),
                ),
              ],
            )
          : Row(
              children: [
                SfCircularChart(
                  series: [
                    PieSeries(
                      dataSource: exp.entries.toList(),
                      xValueMapper: (entry, _) => entry.key.toString(),
                      yValueMapper: (entry, _) => entry.value,
                      name: exp.entries.toString(),
                      animationDuration: 1200,
                      explode: true,
                    ),
                  ],
                ),
                Expanded(
                    child: expense_list(_registered_expenses, deleteExpense)),
              ],
            );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true,
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (context) => add_expense(submitData),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: screenWidget,
    );
  }
}
