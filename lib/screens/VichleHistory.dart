import 'package:flutter/material.dart';

class VichileHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      height: 150,
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
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Booking From",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Text("XXXX",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Booking To",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Text("XXXX",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Total Distance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Text("20",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
