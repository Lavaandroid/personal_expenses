import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);


  @override
  Widget build(BuildContext context) {
    return   LayoutBuilder(builder: (ctx, constraints) {   //constraints definiuja jak widget ma byc wyswietlony wielkosc itp. Zawsze odnosza sie do height i width i sa ograniczane przez max i min

      return Column(children: <Widget>[
        Container(
          height: constraints.maxHeight *0.15,
          child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(2)}')
          ),
        ),          //gdy tekst bedzie za dlugi to sie zwezy
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight *0.6,     //zajmie 50% maksymalnej wysokosci
          width: 10,
          child: Stack(children: <Widget>[      //zapelni stopniowo bar w zaleznosci od procentu, stack pozwala umieszczac wodgety jeden na drugim przez overlapping
            Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1.0),
              color: Color.fromRGBO(220, 220, 220, 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),),)
          ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight *0.05
          ,),
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label)))
      ],);
    },);

    }
  }
