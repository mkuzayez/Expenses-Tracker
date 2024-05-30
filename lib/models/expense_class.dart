// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Category { food, leisure, travel, work, other }

var formatter = DateFormat.yMd();

const categoryIcones = {
  Category.food: Icons.restaurant,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
  Category.other: Icons.home,
  };

class Expense {
  final Category category;
  final String title;
  final double amount;
  final DateTime date;

  const Expense(
      {required this.title,
      required this.category,
      required this.amount,
      required this.date});

  String get formatedDate {
    return formatter.format(date);
  }
}
