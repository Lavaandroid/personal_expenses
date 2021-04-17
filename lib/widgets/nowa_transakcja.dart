import 'package:flutter/material.dart';

class NowaTransakcja extends StatelessWidget {
  final Function addTx;
  final titleController=TextEditingController();
  final amountController=TextEditingController();

  NowaTransakcja(this.addTx);

  void submitData(){

    final enteredTitle=titleController.text;
    final enteredAmount= double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <=0) {
      return;
    }

      addTx(
          enteredTitle,
          enteredAmount,
      );

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

              controller: titleController,
              onSubmitted: (_)=>submitData(),

              //onChanged: (value) {
               // titleInput=value;
              //},
            ),
            TextField(decoration: InputDecoration(labelText: 'Amount'),

              controller: amountController,
              keyboardType: TextInputType.number, //powoduje, ze klawiatura wyswietli tylko cyfry
              onSubmitted: (_) => submitData(),
              //onChanged: (val)=>amountInput=val,
            ),

            TextButton(child: Text(
              'Dodaj transakcję',
              style: TextStyle(color: Colors.yellowAccent),
            ),
                onPressed: ()=> submitData,

            )],
        ),
      ),
    );
  }
}