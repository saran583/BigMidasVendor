import "package:flutter/material.dart";

class Privacy extends StatelessWidget{
  static String routeName="/privacy";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Center(
      child:
      Padding(padding: EdgeInsets.all(15),
      child: Column(
        children:[ 
          SizedBox(
            height: 60
          ),
          Text("Privacy Policy", style: TextStyle( fontSize: 30, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 50
          ),
          Text("Welcome to Big Midas! \n \nThese terms and conditions outline the rules and regulations for the use of Big Midas. \n \nBy accessing this application we assume you accept these terms and conditions. Do not continue to use Big Midas if you do not agree to take all of the terms and conditions stated on this page.", style: TextStyle(fontSize: 15, color: Colors.black)),
        ]
      )
    )
    )
    );
    throw UnimplementedError();
  }
}