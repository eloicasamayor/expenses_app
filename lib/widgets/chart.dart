import './chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    //.generate es un método contenido en cualquier List, el cual nos genera una lista
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      //para calcular la suma total de gastos en los ultimos 7 dias, recorremos todos los recentTransactions
      // y para cada dia sumamos el amount a totalSum.
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      //print(DateFormat.E().format(weekDay));
      //print(totalSum);
      // al dia de hoy le restamos (index) dias.
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
      // DateFormat.E(datatime) nos devuelve la inicial de el dia de la semana que le pasamos por argumento. Forma parte del package intl
    }).reversed.toList();
    // (43)
    // .reversed() -> método de List que genera una lista con el orden al revés.( de hecho nos devuelve un iterable, que podemos convertir de nuevo a lista con el .toList)
  }

  // (39)
  // getter para calcular la suma de los gastos totales de la semana
  // usaremos .fold(), un método de List que nos permite convertir una lista a otro tipo de variable, con una lógica definida en una función que le pasamos como parámetro.
  // a fold() le pasamos 2 parámetros:
  // - valor de inicio
  // - función anónima la cual retorna un valor el cual será añadido al valor de inicio. A su vez, esta función recibe 2 parámetros:
  //   > "suma calculada actual": valor que va cambiando y se va agregando al valor de inicio
  //   > elemento de la lista
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              // Para evitar que los elementos crezcan y se repartan el espacio según el contenido, ponemos el chart dentro de un Flexible con el atributo fit: FlexFit.tight
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
