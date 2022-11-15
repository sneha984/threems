
import 'package:flutter/material.dart';


class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}


class _ExpenseState extends State<Expense> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
              child: Text("Expense"),
            ),
          );



  }
}
