import 'package:expense_craker/Widget/chart/chart.dart';
import 'package:expense_craker/Widget/expenses_list/expenses_list.dart';
import 'package:expense_craker/Widget/new_expense.dart';


import 'package:flutter/material.dart';
import 'package:expense_craker/model/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState(){
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses=[
    Expense(
      title: 'flutter course',
       amount: 19.99,
        date: DateTime.now(), 
       category:Category.work,),
       Expense(
      title: 'cinema',
       amount: 15.99,
        date: DateTime.now(), 
       category :Category.leisure,
       ),

  ];

  void _openAddExpenserOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
       builder: (ctx)=> NewExpense(onAddExpense: _addExpense),
    );
  }
   void _addExpense (Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
   }
   void _removeExpense(Expense expense){
    final exoenseIndex =_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration:const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(exoenseIndex,expense);
            });
          },
        ),
      ),
    );
   }

  @override
  Widget build(BuildContext context) {
   
   final width =MediaQuery.of(context).size.width;

    Widget mainContent= const Center(
      child: Text('No expenses found.Start adding some'),
    );
     
     if(_registeredExpenses.isNotEmpty){
      mainContent=ExpensesList(
          expenses:_registeredExpenses,
          onRemoveExpense:_removeExpense,
          );
     }
     
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenserOverlay,
            icon:const Icon(Icons.add),
            ),
        ],
      ),
      body:width< 600
       ? Column(
        children:[
          Chart(expenses: _registeredExpenses),
        Expanded(
          child: mainContent,
          ),
        ],
        )
       : Row (children: [
          Expanded(
            child: Chart(expenses: _registeredExpenses)
            ),
          Expanded(
            child: mainContent
          ),
        ],)
    );
  }
}

