import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

// (24)
// ListView
// Se puede usar de 2 formas
// - Como widget normal: cuando sabemos cuántos hijos habrá y serán pocos. Renderiza todos los hijos, aunque no estén en pantlla.
// - ListView.builder: para listas grandes. No renderiza los hijos fuera de pantalla, con lo cual es mejor en cuanto a performance.
//      ListView.builder (itemBuilder: (context, index) { return <widget para cada hijo> para recorrer una lista: nombreLista[index]})

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No Transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover)),
                //Para poder usar imagenes, tenemos que incluirlas en una carpeta y referenciarlas en pubspec.yaml
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                elevation: 4,
                child: ListTile(
                  // ListTile: widget preparado para listas de elementos
                  // tiene varios subelementos ya definidos, como leading, title, subtitle...
                  leading: CircleAvatar(
                    radius: 30,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                ),
              );

              // Es como un Column + SingleChildScrollView. Pero tiene que tener un padre con una height definida.
              // ListView se puede usar como un widget normal, o bien llamar al ListView.builder()
              // con ListView.builder(), solo se renderiza los items visibles. Es mejor para listas largas.
            },
            itemCount: transactions.length,
          );
  }
}
