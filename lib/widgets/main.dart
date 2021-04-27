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
    final appBar=AppBar(
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
      return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView( // SingleChildScrollView dodaje mozliwosc scrollowania, trzeba dodac zawsze przy body
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            //pozycjonuje column, start to początek (na gorze) aplikacji, a end to na dole
            crossAxisAlignment: CrossAxisAlignment.stretch,


            children: <Widget>[

              if(isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                Text('Show Cart'),
                Switch(value: _showChart, onChanged: (val) {
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () =>_startAddNewTransaction(context),), //w scaffold

      );
    }
  }