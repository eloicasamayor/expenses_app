import 'dart:io';

import 'package:flutter/cupertino.dart';
// cupertino.dart incluye los widgets para iOS
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() {
  /* (8) Para hacer que la aplicación solo se pueda usar en Portrait mode (vertical)
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        // y estos afectarán a todos los headline6 que no estén dentro del appbar
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
          //Para poder usar diferentes fuentes, tenemos que incluirlas en una carpeta y referenciarlas en pubspec.yaml
          // copiamos el tema y sobreescribimos lo que queremos que sea diferente
          //en este caso, afectará a todos los objetos marcados como "headline6" dentro de AppBar
        ),
      ),
      // (30)
      // el Tema (theme) es un objeto que almacena los elementos de estilo para la aplicación.
      // podemos acceder a él desde cualquier lugar, mediante "Theme.of(context)."
      //Swatch es como una gama de colores. le decimos uno y flutter crea como una gama donde podemos escojer varios.
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly groceries',
    //   amount: 70.70,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    //where -> método de la clase List el cual ejecuta una función para cada elemento de la lista.
    // si la función devuelve true, el elemento es incluido en la nueva lista devuelta, si devuelve falso, no se incluirá.
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
    // Tenemos que añadir el ".toList()" porque el .where devuelve un iterable, no una lista. el .toList() convierte el iterable a una lista.
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    //podemos usar las mediaqueries tambien para saber en qué orientacion estamos (landsape / portrait)
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    // ponemos el widget AppBar dentro de una variable para poder acceder a él (y a sus atributos) desde otras clases. Por ejemplo, para calcular alturas con las MediaQueries.
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );
    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        _userTransactions,
        _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //otra manera de construir widgets según una condición: poner if(condición) seguido del widget.
              if (isLandscape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Show Chart'),
                      // (15)
                      // Algunos widgets tienen el constructor .adaptative(), el cual lo crea de diferente estilo según la plataforma (ios / android)
                      Switch.adaptive(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          }),
                    ],
                  ),
                ),
              if (!isLandscape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  // MediaQuery.of(context).padding.top -> la barrita de arriba de las notificaciones
                  // appBar.preferredSize.height -> altura de la appBar
                  child: Chart(_recentTransactions),
                ),
              if (!isLandscape) txListWidget,
              if (isLandscape)
                _showChart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        // MediaQuery.of(context).padding.top -> la barrita de arriba de las notificaciones
                        // appBar.preferredSize.height -> altura de la appBar
                        child: Chart(_recentTransactions),
                      )
                    : txListWidget,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Platform.isIOS
          // su estanis en iOS, no construimos el FloatingActionButton.
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
    );
  }
}
