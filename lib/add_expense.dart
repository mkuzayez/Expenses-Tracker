// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import './models/expense_class.dart';
import 'package:string_capitalize/string_capitalize.dart';

// ignore: must_be_immutable
class add_expense extends StatefulWidget {
  const add_expense(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<add_expense> createState() => _add_expenseState();
}

class _add_expenseState extends State<add_expense> {
  TextEditingController selectedTitle = TextEditingController();
  TextEditingController selectedAmount = TextEditingController();
  Category? selectedCategorty;
  DateTime? selectedDate;

  Future<void> datePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void addExpense() {
    if (selectedTitle.text.isEmpty ||
        selectedAmount.text.isEmpty ||
        selectedCategorty == null ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "Invalid input(s). Try again.",
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Ok"),
            )
          ],
        ),
      );
    } else {
      setState(
        () {
          widget.onAddExpense(
            Expense(
                title: selectedTitle.text,
                category: selectedCategorty!,
                amount: double.tryParse(selectedAmount.text)!,
                date: selectedDate!),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(16, 36, 16, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                maxLines: 1,
                controller: selectedTitle,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Name",
                  prefix: Text("   "),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextField(
                      controller: selectedAmount,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Amount",
                        prefix: Text("\$ "),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    selectedDate == null
                        ? "No date selected"
                        : formatter.format(selectedDate!),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: datePicker,
                    icon: const Icon(Icons.date_range),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DropdownButton(
                    hint: const Text("Category"),
                    iconSize: 24,
                    value: selectedCategorty,
                    items: Category.values
                        .map(
                          (catagory) => DropdownMenuItem(
                            value: catagory,
                            child: Text(
                              catagory.name.capitalize(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(
                        () {
                          selectedCategorty = value;
                        },
                      );
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: addExpense,
                    style: const ButtonStyle(
                      iconSize: MaterialStatePropertyAll(20.0),
                      // backgroundColor:
                      //     MaterialStatePropertyAll(Colors.indigo),
                    ),
                    child: const Text(
                      "Submit",
                      // style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      iconSize: MaterialStatePropertyAll(20.0),
                      // backgroundColor:
                      //     MaterialStatePropertyAll(Colors.indigo),
                    ),
                    child: const Text(
                      "Cancle",
                      // style: TextStyle(color: Colors.white),
                    ),
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
