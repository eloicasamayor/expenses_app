import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctgOfTogal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctgOfTogal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        // Constraints es una característica de Flutter que nos defice cuánto espacio puede ocupar un Widget.
        // se definen cuando asignas height y width, o tambien todos los widgets tienen unas constraints por defecto.
        builder: (context, constraints) {
      //El LayoutBuilder nos permite acceder a las dimensiones (constraints) del widget.
      return Column(
        children: [
          // FittedBox le dice a su hijo que no puede crecer, si el contenido no cabe pues tiene que reducir la letra para que quepa.
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctgOfTogal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              )),
        ],
      );
    });
  }
}
