import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/lista_transakcji.dart';
import 'package:personal_expenses/widgets/nowa_transakcja.dart';
import '../models/transakcje.dart';


void main() {
  runApp(MyApp());
}

  class MyApp extends StatelessWidget{

    @override
  Widget build(BuildContext context) {  //context to objekt zawierajacy duzo informacji jak wybudiwac

      return MaterialApp(
      title:'Personal Expenses ',
      theme: ThemeData(
        primarySwatch: Colors.purple, //primaryColor to jeden kolor, a swatch podaje sie jeden kolor, ale generuje w tle inne odcienie
      accentColor: Colors.amberAccent, //alternatywny kolor, sluzy do mieszania kolorow w aplikacji
      //errorColor: Colors.red,
          fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          button: TextStyle(color: Colors.yellow)
        ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
            )
        )
      ),    //globalne style
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

   // Transakcja(
    //  id: 'z1', title: 'Nowe buty', amount: 239.99, date: DateTime.now(),),
   // Transakcja(id: 'z2', title: 'Rolki', amount: 399.99, date: DateTime.now(),)


  ];

  List<Transakcja> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount,  DateTime chosenDate) {
    final newTx = Transakcja(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
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
    void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id==id;
      });
    });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.yellowAccent,
          title: Text('Personal Expenses App',),
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

              Chart(_recentTransactions),

              ListaTransakcji(_userTransactions, _deleteTransaction)


            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () =>_startAddNewTransaction(context),), //w scaffold

      );
    }
  }