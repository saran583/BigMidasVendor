import 'package:flutter/material.dart';

class ServiceHistory extends StatefulWidget {
  @override
  _ServiceHistoryState createState() => _ServiceHistoryState();
}

class _ServiceHistoryState extends State<ServiceHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      height: 160,
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
                // Expanded(
                //   child: Text("INR2,978.00",
                //       textAlign: TextAlign.end,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       )),
                // )
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Booking Date",
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
                Text("Booking Time",
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
                Text("Booking Location",
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
                Text("Amount Paid",
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
