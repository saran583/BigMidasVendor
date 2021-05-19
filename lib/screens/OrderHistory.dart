
import 'package:flutter/material.dart';

import 'ListOfHistory.dart';
import 'ListOfServiceHistory.dart';
import 'ListOfVichleHistory.dart';

class OrderHistory extends StatefulWidget {
  static String routeName="/orderhistory";
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int showDetails = 0;

  static List<Widget> _widgetOptions1 = <Widget>[
    ListOfHistory(),
    ListOfVichleHistory(),
    ListOfServiceHistory(),
    // StoreProfile(),
    // DriverProfiel(),
    // DriveScreen(),
    // HomePage(),
    // ServicesPage(),
    // SearchService(),
    // AddAddress(),
    // PaymentPage(),
    // ShowProfile(),
    // StoreView(),
    // AddAddress(),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        margin: EdgeInsets.all(12),
        height: 40,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: Container(
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      // borderRadius: BorderRadius.circular(9.0),
                      // side: BorderSide(
                      //     color: this.showDetails == 0
                      //         ? Colors.red
                      //         : Colors.white

                      //         )
                      ),
                  color: this.showDetails == 0
                      ? Color.fromRGBO(118, 54, 152, 1)
                      : Colors.white,
                  onPressed: () => {
                        this.setState(() {
                          this.showDetails = 0;
                        })
                      },
                  child: Text(
                    "Store",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: this.showDetails == 0
                            ? Colors.white
                            : Colors.black),
                  )),
            )),
            Expanded(
                child: FlatButton(
                    color: this.showDetails == 1
                        ? Color.fromRGBO(118, 54, 152, 1)
                        : Colors.white,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(9.0),
                    //     side: BorderSide(
                    //         color: this.showDetails == 1
                    //             ? Colors.red
                    //             : Colors.white)),
                    onPressed: () => {
                          this.setState(() {
                            this.showDetails = 1;
                          })
                        },
                    child: Text(
                      "Vehicles",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: this.showDetails == 1
                              ? Colors.white
                              : Colors.black),
                    ))),
            Expanded(
                child: FlatButton(
                    color: this.showDetails == 2
                        ? Color.fromRGBO(118, 54, 152, 1)
                        : Colors.white,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(9.0),
                    //     side: BorderSide(
                    //         color: this.showDetails == 2
                    //             ? Colors.red
                    //             : Colors.white)),
                    onPressed: () => {
                          this.setState(() {
                            this.showDetails = 2;
                          })
                        },
                    child: Text(
                      "Services",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: this.showDetails == 2
                              ? Colors.white
                              : Colors.black),
                    )))
          ],
        ),
      ),
      _widgetOptions1.elementAt(showDetails),
    ]);
  }
}
