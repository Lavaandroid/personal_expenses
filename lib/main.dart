import 'package:flutter/material.dart';
import 'transakcje.dart';

void main() {
  runApp(MyApp());
}

  class MyApp extends StatelessWidget{

    @override
  Widget build(BuildContext context) {

      return MaterialApp(
      title:'Personal Expenses ',
      home: MyHomePage(),
      );
  }
  }

  class MyHomePage extends StatelessWidget{

  final List<Transakcja> transakcje=[ //mowi, ze transakcje bedzie zawierac liste z funkcji transakcja
  Transakcja(id: 'z1', title:'Nowe buty', amount: 239.99, date: DateTime.now(),),
    Transakcja(id: 'z2', title:'Rolki', amount: 399.99, date: DateTime.now(),)
  ];
    @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses App'),
        ),
        body: Column(

          mainAxisAlignment: MainAxisAlignment.spaceAround, //pozycjonuje column, start to początek (na gorze) aplikacji, a end to na dole
          crossAxisAlignment: CrossAxisAlignment.stretch,


          children: <Widget>[
            
            Container(
            width:double.infinity,
          child: Card(    //wykres z wydatkami, rozmiar card zalezy od child, aletekst zalezy od rozmiaru parent, wiec musze wprowadzic nowy widget, ktorym bede mogl zmienic rozmiar

            color: Colors.red,
            child: Text('CHART'),
            elevation: 5,
          ),
        ),


            Column(   //lista transakcji, musze utworzyc mape z transakcje, zeby wyswietlana lista byla dynamiczna, nie wiem ile transakcji ktos wpisze

                children: transakcje.map((tx){
                  return Card(
                  child: Row(
                    children: <Widget>[

                    Container(

                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(border: Border.all(color: Colors.lightBlue, width: 2)),
                      padding: EdgeInsets.all(10),

                      child: Text(tx.amount.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.lightBlue),
                    ),
                    ),

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text(tx.title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),

                      ),
                      Text(tx.date.toString(),
                      style: TextStyle(color: Colors.grey),

                      )
                    ],)

                  ],),
                  );
            }).toList(),
            ),
        ],
      ),
      );

  }
  }


