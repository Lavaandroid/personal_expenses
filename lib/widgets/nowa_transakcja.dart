import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:personal_expenses/widgets/adaptive_flat_button.dart';

class NowaTransakcja extends StatefulWidget {
  final Function addTx;

  NowaTransakcja(this.addTx);

  @override
  _NowaTransakcjaState createState() => _NowaTransakcjaState();
}

class _NowaTransakcjaState extends State<NowaTransakcja> {
  final _titleController=TextEditingController();
  final _amountController=TextEditingController();
  DateTime _selectedDate;

  void _submitData(){
  if(_amountController.text.isEmpty){
    return;
  }
    final enteredTitle=_titleController.text;
    final enteredAmount= double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <=0 || _selectedDate==null) {
      return;
    }

      widget.addTx(
          enteredTitle,
          enteredAmount,
          _selectedDate,
      );

    Navigator.of(context).pop(); //zamknie formularz po wprowadzeniu danych

    }

    void _presentDatePicker() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate==null) {
        return;
      }
      setState(() {
        _selectedDate=pickedDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(   //bedzie mozna scrollowac arkusz w widoku klawiatury
      child: Card(

        elevation: 5,
        child: Container(

          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),    //mowi ile ma zajac klawiatura

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: <Widget> [
              //CupertinoTextField()

              TextField(decoration: InputDecoration(labelText: 'Title'),

                controller: _titleController,
                onSubmitted: (_)=>_submitData(),

                //onChanged: (value) {
                 // titleInput=value;
                //},
              ),
              TextField(decoration: InputDecoration(labelText: 'Amount'),

                controller: _amountController,
                keyboardType: TextInputType.number, //powoduje, ze klawiatura wyswietli tylko cyfry
                onSubmitted: (_) => _submitData(),
                //onChanged: (val)=>amountInput=val,
              ),

              Container(
                height: 70,
                child: Row(
                  children: <Widget> [
                  Expanded(
                      child: Text(
                          _selectedDate== null
                              ? 'Nie wybrano daty'
                              : DateFormat.yMd().format(_selectedDate)
                      )
                  ),
                    
                    AdaptiveFlatButton('Podaj datę', _presentDatePicker)




                ],),
              ),

              RaisedButton(
                child: Text('Dodaj transakcję'),
                  color: Theme.of(context).primaryColor,
                  textColor:Theme.of(context).textTheme.button.color,
                  onPressed: ()=> _submitData,


              )],
          ),
        ),
      ),
    );
  }
}
