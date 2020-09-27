import 'package:flutter/material.dart';

class ChartBarN extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBarN(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Row(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
               child: 
                 Text('\$${spendingAmount.toStringAsFixed(0)}',style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),),
            
            ),
            SizedBox(
              width: constraints.maxWidth * 0.05,
            ),
            Container(
              height: 10,
              width: constraints.maxWidth * 0.6,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: 
                 Text(label,style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),),
              
            ),
          ],
        );
      },
    );
  }
}
