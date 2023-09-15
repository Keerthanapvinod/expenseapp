import 'package:expense_craker/Widget/expenses_list/expenses_item.dart';
//import 'package:expense_craker/main.dart';
import 'package:expense_craker/model/expense.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
    });



  final List<Expense> expenses;
  final void Function (Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:expenses.length ,
      itemBuilder: (ctx, index) =>Dismissible(
        key: ValueKey(expenses[index]),
        background:Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal:Theme.of(context).cardTheme.margin!.horizontal
            ),
        ) ,
        onDismissed:(direcion){
          onRemoveExpense(expenses[index]);
        },
       child: ExpenseItem(
        expenses[index],
        ),
      ),
    );
  }
}