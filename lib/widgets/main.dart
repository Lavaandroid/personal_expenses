import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personal_expenses/widgets/lista_transakcji.dart';
import 'package:personal_expenses/widgets/nowa_transakcja.dart';
import '../models/transakcje.dart';


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

  class MyHomePage extends StatefulWidget {
    //String titleInput;
    //String amountInput;

    @override
    _MyHomePageState createState() => _MyHomePageState();
  }

class _MyHomePageState extends State<MyHomePage> {
  final List<Transakcja> _userTransactions = [
    //mowi, ze transakcje bedzie zawierac liste z funkcji transakcja

    Transakcja(
      id: 'z1', title: 'Nowe buty', amount: 239.99, date: DateTime.now(),),
    Transakcja(id: 'z2', title: 'Rolki', amount: 399.99, date: DateTime.now(),)


  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transakcja(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

    void _startAddNewTransaction(BuildContext ctx) {
      //funckja do pokazania formluarza do wpisana transakcji
      showModalBottomSheet(context: ctx, builder: (_)
      {
        return GestureDetector(
          onTap: () {}, //nie zamknie sie gdy klikne tam gdzie jest formularz
          child: NowaTransakcja(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
    },
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses App'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: ()=>_startAddNewTransaction(context),)
          ],
        ),
        body: SingleChildScrollView( // SingleChildScrollView dodaje mozliwosc scrollowania, trzeba dodac zawsze przy body
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            //pozycjonuje column, start to początek (na gorze) aplikacji, a end to na dole
            crossAxisAlignment: CrossAxisAlignment.stretch,


            children: <Widget>[

              Container(
                width: double.infinity,
                child: Card( //wykres z wydatkami, rozmiar card zalezy od child, aletekst zalezy od rozmiaru parent, wiec musze wprowadzic nowy widget, ktorym bede mogl zmienic rozmiar

                  color: Colors.red,
                  child: Text('CHART'),
                  elevation: 5,
                ),
              ),

              ListaTransakcji(_userTransactions)


            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () =>_startAddNewTransaction(context),), //w scaffold

      );
    }
  }