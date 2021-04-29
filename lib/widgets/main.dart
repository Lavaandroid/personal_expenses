import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/lista_transakcji.dart';
import 'package:personal_expenses/widgets/nowa_transakcja.dart';
import '../models/transakcje.dart';


void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);    //wymusza orientacje pionowa telefonu, aplikacja sie nie obroci
  runApp(MyApp());
  
}

  class MyApp extends StatelessWidget{

    @override
  Widget build(BuildContext context) {  //context to objekt zawierajacy duzo informacji jak wybudiwac

      return //Platform.isIOS ? CupertinoApp(
       // title:'Personal Expenses ',
        //theme: CupertinoThemeData(
           // primarySwatch: Colors.purple, //primaryColor to jeden kolor, a swatch podaje sie jeden kolor, ale generuje w tle inne odcienie
          //  accentColor: Colors.amberAccent, //alternatywny kolor, sluzy do mieszania kolorow w aplikacji
            //errorColor: Colors.red,
          //  fontFamily: 'Quicksand',
          //  textTheme: ThemeData.light().textTheme.copyWith(
           //     title: TextStyle(
          //        fontFamily: 'OpenSans',
           //       fontSize: 18,
             //     fontWeight: FontWeight.bold,
            //    ),
           //     button: TextStyle(color: Colors.yellow)
          //  ),
           // appBarTheme: AppBarTheme(
              //  textTheme: ThemeData.light().textTheme.copyWith(
               //     title: TextStyle(
                //      fontFamily: 'OpenSans',
                //      fontSize: 20,
                 //     fontWeight: FontWeight.bold,
               //     )
            //    )
            //)
      //  ),    //globalne style
       // home: MyHomePage(),
     // ) :
           MaterialApp(
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

  bool _showChart =false;

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
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;     //sprawdzi w jakiej orientacji jest  urzadzenie
    final mediaQuery= MediaQuery.of(context);   //zeby zyskac performance i ominac dodatkowe renderowanie, gdy uzywam duzo mediaQuery zamiast za kazdym razem MediaQuery.of(context) to tworze zmienna
    final PreferredSizeWidget appBar= Platform.isIOS ? CupertinoNavigationBar(//przez ten warunek logiczny dart nie widzi, ze appbar ma preferred size, wiec musze okreslic te zmienna manualnie

      middle: Text('Personal Expenses app'),  //middle to title w ios
    trailing: Row(      //triling to to samo co actions, zeby dodac cos na koncu appbar
      mainAxisSize: MainAxisSize.min,   //defaultowo row zabiera maksymalna szerokosc jaka moze tak samo jak kolumna maksymalna wysokosc, za pomoca tego ograniczam miejsce
      children: <Widget> [

      GestureDetector(      // w cupertino nie ma odpowiednika iconbutton, wiec trzeba zbudowac przycisk samemu
        child: Icon(CupertinoIcons.add),
        onTap: ()=>_startAddNewTransaction(context),)

    ],),
    ) : AppBar(
      //backgroundColor: Colors.yellowAccent,
      title: Text(
        'Personal Expenses App',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: ()=>_startAddNewTransaction(context),
        ),
      ],
    );
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height - appBar.preferredSize.height- MediaQuery.of(context).padding.top)*0.7,
        child: ListaTransakcji(_userTransactions, _deleteTransaction));
    final pageBody = SafeArea(child: SingleChildScrollView( // SingleChildScrollView dodaje mozliwosc scrollowania, trzeba dodac zawsze przy body. SafeArea chroni przed zarezerwowanym miejscem np. przez notcha
      child: Column(

      mainAxisAlignment: MainAxisAlignment.start,
      //pozycjonuje column, start to początek (na gorze) aplikacji, a end to na dole
      crossAxisAlignment: CrossAxisAlignment.stretch,


      children: <Widget>[

      if(isLandscape) Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
      Text('Show Cart', style: Theme.of(context).textTheme.title,),
      Switch.adaptive(      //.adaptive zrobi, ze switch zmieni sie na IOSie
      activeColor: Theme.of(context).accentColor,   //na IOSie switch, gdy bedzie aktywny domyslnie stanie sie zielony, zeby spersonalizwoac ten kolor do aplikacji uzwyam tego
      value: _showChart, onChanged: (val) {
      setState(() {
      _showChart=val;
      });
      },)

      ],),

      if (!isLandscape)   Container(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3, // mediaquery robi responsywnosc, conrainer bedzie zajmowal 30%, padding top odejmie miejsce zajmowane przez status bar
      child: Chart(_recentTransactions),
      ),

      if(!isLandscape) txListWidget,
      if (isLandscape) _showChart
      ?   Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height-mediaQuery.padding.top)*0.7, // mediaquery robi responsywnosc, conrainer bedzie zajmowal 30%, padding top odejmie miejsce zajmowane przez status bar
      child: Chart(_recentTransactions),
      )

          : txListWidget


      ],
      ),
      ));
      return Platform.isIOS ? CupertinoPageScaffold(child: pageBody, navigationBar: appBar,) : Scaffold(    //sprawdza jaka platrorma i renderuje odpowiedni scaffold
        appBar: appBar,
        body: pageBody,

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(    //Platform.isPlatfroma pochodzi z dart:io i sprawdza z jakiego systemu korzystam
          child: Icon(Icons.add), onPressed: () =>_startAddNewTransaction(context),), //w scaffold

      );
    }
  }