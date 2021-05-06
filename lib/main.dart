import './widgets/user_transactions.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                child: Text('CHART!'),
                elevation: 5,
                color: Colors.blue,
              ),
              UserTransactions(),
            ],
          ),
        ),
      ),
    );
  }
  // (5) Alineacion Column / Row
  // mainAxisAlignment: alineación respecto al eje principal (para Row es el eje vertical y para Column es el eje horizontal)
  //
  // Container vs Column/Row
  // - El Container solo puede tener un hijo                   --- en row/column puede tener los hijos que quieras.
  // - Container tiene muchas opciones de alinear y styling    --- en column /row solo puedes alinear, styling.
  // - Container puede tener tamaño flexible, puedes manejarlo --- row tiene siempre la máxima anchura y column la máxima altura.
  //
  // (15) String Interpolation
  // En vez de nombreVariable.toString(), podemos usar $nombreVariable
  // Si queremos usar una expresion mas larga -> ${nombreObjeto.nombreParametro + 'otro string'}
  //
  // Para 'escapar cualquier carácter, usaremos la contrabarra seguida del símbolo: \$
  //
  // (19) textEditingController
  // objeto que maneja la información introducida en un textField.
  // tienes que crearlo como textEditingController y asignarlo "controller: nombreDelController"
}
