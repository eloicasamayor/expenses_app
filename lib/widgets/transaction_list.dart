import 'package:flutter/material.dart';

import '../models/transaction.dart';

// (24)
// ListView
// Se puede usar de 2 formas
// - Como widget normal: cuando sabemos cuántos hijos habrá y serán pocos. Renderiza todos los hijos, aunque no estén en pantlla.
// - ListView.builder: para listas grandes. No renderiza los hijos fuera de pantalla, con lo cual es mejor en cuanto a performance.
//      ListView.builder (itemBuilder: (context, index) { return <widget para cada hijo> para recorrer una lista: nombreLista[index]})

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover)),
                //Para poder usar imagenes, tenemos que incluirlas en una carpeta y referenciarlas en pubspec.yaml
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                            //.toStringAsFixed -> para convertir a string con un número definido de decimales.
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            transactions[index].date.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          )
                        ],
                      ),
                    ],
                  ),
                );

                // Es como un Column + SingleChildScrollView. Pero tiene que tener un padre con una height definida.
                // ListView se puede usar como un widget normal, o bien llamar al ListView.builder()
                // con ListView.builder(), solo se renderiza los items visibles. Es mejor para listas largas.
              },
              itemCount: transactions.length,
            ),
    );
  }
}
