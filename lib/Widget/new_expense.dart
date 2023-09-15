

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_craker/model/expense.dart';
//import 'package:flutter/services.dart';


class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
   return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{
  final _tilteController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory=Category.leisure;



  void _presentDatepicker() async {
    final now = DateTime.now();
    final firstDate =DateTime(now.year-1,now.month,now.day);
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now,
    );
   setState(() {
     _selectedDate=pickedDate;
   }); //print(pickedDate);
  }

  void _showDialog(){
    if (Platform.isIOS){
    showCupertinoDialog(
        context: context, builder: (ctx)=>CupertinoAlertDialog(
         title:const Text('Invalid input'),
        content: const Text('please make sure a valid title, ammount,date and category was enterd.'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(ctx);
            },
            child:const Text('okay'),
          ),
        ],
        ));
    } else {
      // show error message
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title:const Text('Invalid input'),
        content: const Text('please make sure a valid title, ammount,date and category was enterd.'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(ctx);
            },
            child:const Text('okay'),
          ),
        ],
      ),
      );
    }
    
      

  }

  void _submitExpensesData(){
   final enteredAmount=double.tryParse (_amountController.text);
   final ammountIsInvalid = enteredAmount==null|| enteredAmount<=0;
    if (_tilteController.text.trim().isEmpty || 
    ammountIsInvalid ||
     _selectedDate==null) {
      _showDialog();
  
      
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _tilteController.text,
         amount: enteredAmount, 
         date: _selectedDate!, 
         category: _selectedCategory
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _tilteController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keybordSpace=MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constraints){
     final width = constraints.maxWidth;

       return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16,16,16,keybordSpace+16),
          child:Column(
            children: [
             if (width>=600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                Expanded(child:  TextField(
                  controller: _tilteController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title')
                  ),
                ),
                ),
                const SizedBox(width: 24),
                Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType:TextInputType.number,
                decoration:const InputDecoration(
                  prefixText:'\$' ,
                  label: Text('Amount'),
                ),
              ),
            ),
              ],
            )
                else
                TextField(
                  controller: _tilteController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                if (width>=600)
               
                Row(children: [
                   DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                  .map(
                 (category) => DropdownMenuItem(
                  value: category,
                  child: Text(
                    category.name.toUpperCase(),
                    ),
                    ),
                )
                .toList(), 
                onChanged: (value){
                  if (value==null){
                    return;
                  }
                  setState(() {
                    _selectedCategory= value;
                  });
                },
                ), 
                  const SizedBox(width: 24),
                  Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _selectedDate== null
                 ? 'no date selected'
                 :formatter.format(_selectedDate!),
                 ),
               IconButton(
               onPressed: _presentDatepicker,
                icon:const Icon(
                  Icons.calendar_month,
                ),
                ),
              ],
              ),
            ),
                ])
                else
            Row(
              children: [
             Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType:TextInputType.number,
                decoration:const InputDecoration(
                  prefixText:'\$' ,
                  label: Text('Amount'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _selectedDate== null
                 ? 'no date selected'
                :formatter.format(_selectedDate!),
                ),
               IconButton(
               onPressed: _presentDatepicker,
                icon:const Icon(
                  Icons.calendar_month,
                ),
                ),
              ],
              ),
            ),
            ],
          ),
          const SizedBox(height: 16),
             if (width>=600)
             Row(children: [
              const Spacer(),
                TextButton(
                  onPressed: (){
                 Navigator.pop(context);
                }, 
                child:const Text('cancel')
                ),
              ElevatedButton(
                onPressed:_submitExpensesData,
                child:const Text('save expense'),
                ),])
             else
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                  .map(
                 (category) => DropdownMenuItem(
                  value: category,
                  child: Text(
                    category.name.toUpperCase(),
                    ),
                    ),
                )
                .toList(), 
                onChanged: (value){
                  if (value==null){
                    return;
                  }
                  setState(() {
                    _selectedCategory= value;
                  });
                },
                ),
                const Spacer(),
                TextButton(
                  onPressed: (){
                 Navigator.pop(context);
                }, 
                child:const Text('cancel')
                ),
              ElevatedButton(
                onPressed:_submitExpensesData,
                child:const Text('save expense'),
                ),
            ],
            ),
          ],
          ) ,
        ),
      ),
    );
    });

   
  }
}