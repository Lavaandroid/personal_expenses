import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../models/transakcje.dart';

class ListaTransakcji extends StatelessWidget {

  final List<Transakcja> transakcje;
  final Function deleteTx;

  ListaTransakcji(this.transakcje, this.deleteTx);



  @override
  Widget build(BuildContext context) {//lista transakcji, musze utworzyc mape z transakcje, zeby wyswietlana lista byla dynamiczna, nie wiem ile transakcji ktos wpisze
    return Container(
      height: 450,
      child: transakcje.isEmpty ? Column(children: <Widget> [
        Text(
          'Brak transakcji',
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 10),  //doda box o wyznaczonym rozmiarze
        Container( height: 200,child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)),
      ],
      )
      : ListView.builder(//ListViw to column z widgetem do scrollowania, ma on nieskonczona wysoskosc    Ewentualnie ListViw.builder() stosowany gdy lista bedzie dluga, bo renderuje tylko to co widac na ekranie

        itemBuilder: (ctx, index){
          // return Card(
          //   child: Row(
          //     children: <Widget>[
          //
          //       Container(
          //
          //         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          //         decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
          //         padding: EdgeInsets.all(10),
          //
          //         child: Text('\$${transakcje[index].amount.toStringAsFixed(2)}',    //string interpolation nie trzeb juz robic toString, bo dart wie, dolar oznacza string interpolation  //Text(PLN +tx.amount.toString())  //toStringAsFixed oznacza ile cyfr po przecinku
          //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColorDark),
          //         ),
          //       ),
          //
          //       Column(
          //
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Text(transakcje[index].title,
          //             style: //TextStyle(
          //                // fontWeight: FontWeight.bold,
          //                // fontSize: 16),
          //             Theme.of(context).textTheme.title,
          //
          //           ),
          //           Text(
          //             DateFormat('y-MM-dd').format(transakcje[index].date), //date format jest z zewnetrznego package intl, .format odrazu zamienia w string wiec juz nie musze miec toString()
          //             style: TextStyle(color: Colors.grey),
          //
          //           )
          //         ],
          //       )
          //
          //     ],
          //   ),
          // );

          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(//widget z domyslnym layoutem
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                        child: Text('\$${transakcje[index].amount}')
                    )
                ),
              ),
              title: Text(transakcje[index].title,
              style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(DateFormat.yMMMd().format(transakcje[index].date)
              ),
              trailing: IconButton(icon: Icon(Icons.delete), color: Theme.of(context).errorColor, onPressed: ()=> deleteTx(transakcje[index].id),),

            ),
          );

        },
        itemCount: transakcje.length, //dzieki temu kod wie ile razy musi wyrenderowac

    ));
  }
}
