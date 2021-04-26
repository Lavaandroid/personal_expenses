import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Card(

      elevation: 5,
      child: Container(

        padding: EdgeInsets.all(10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,

          children: <Widget> [

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
                    child: Text(_selectedDate== null ? 'Nie wybrano daty' : DateFormat.yMd().format(_selectedDate))),
                TextButton(
                  child: Text('Wybierz date', style: TextStyle(fontWeight: FontWeight.bold),), onPressed: _presentDatePicker, style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.green)),)
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
    );
  }
}
