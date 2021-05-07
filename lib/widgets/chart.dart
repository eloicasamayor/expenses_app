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
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      // al dia de hoy le restamos (index) dias.
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
      // DateFormat.E(datatime) nos devuelve la inicial de el dia de la semana que le pasamos por argumento. Forma parte del package intl
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Row(
        children: [],
      ),
    );
  }
}
