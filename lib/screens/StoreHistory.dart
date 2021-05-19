import 'package:flutter/material.dart';

class StoreHistory extends StatefulWidget {
  @override
  _StoreHistoryState createState() => _StoreHistoryState();
}

class _StoreHistoryState extends State<StoreHistory> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      height: 120,
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Order-5243",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Text("INR2,978.00",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            Text(
              "PROCESING",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey),
            ),
            Text("2021 02 02 11:43 AM", style: TextStyle(color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
