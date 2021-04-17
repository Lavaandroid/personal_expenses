import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transakcje.dart';

class ListaTransakcji extends StatelessWidget {

  final List<Transakcja> transakcje;

  ListaTransakcji(this.transakcje);



  @override
  Widget build(BuildContext context) {//lista transakcji, musze utworzyc mape z transakcje, zeby wyswietlana lista byla dynamiczna, nie wiem ile transakcji ktos wpisze
    return Container(
      height: 300,
      child: ListView.builder(//ListViw to column z widgetem do scrollowania, ma on nieskonczona wysoskosc    Ewentualnie ListViw.builder() stosowany gdy lista bedzie dluga, bo renderuje tylko to co widac na ekranie

        itemBuilder: (ctx, index){
          return Card(
            child: Row(
              children: <Widget>[

                Container(

                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(border: Border.all(color: Colors.lightBlue, width: 2)),
                  padding: EdgeInsets.all(10),

                  child: Text('\$${transakcje[index].amount.toStringAsFixed(2)}',    //string interpolation nie trzeb juz robic toString, bo dart wie, dolar oznacza string interpolation  //Text(PLN +tx.amount.toString())  //toStringAsFixed oznacza ile cyfr po przecinku
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.lightBlue),
                  ),
                ),

                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(transakcje[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),

                    ),
                    Text(
                      DateFormat('y-MM-dd').format(transakcje[index].date), //date format jest z zewnetrznego package intl, .format odrazu zamienia w string wiec juz nie musze miec toString()
                      style: TextStyle(color: Colors.grey),

                    )
                  ],
                )

              ],
            ),
          );

        },
        itemCount: transakcje.length, //dzieki temu kod wie ile razy musi wyrenderowac

    ));
  }
}
