

import 'package:bigmidasvendor/utils/hexcolor.dart';
import 'package:flutter/material.dart';



Widget getSignatureButtonShape(String buttonText,Size size)
{
  return Container(

    alignment: Alignment.center,
    height: 50,
    width:size.width-120,
    decoration: BoxDecoration(
      color: HexColor("0E7009"),
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
      // gradient: LinearGradient(
      //   begin: Alignment(0.0, -1.0),
      //   end: Alignment(0.0, 4.14),
      //   colors: [const Color(0xff00c6fb), const Color(0xff0005ba)],
      //   stops: [0.0, 1.0],
      // ),
    ),
    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    margin: EdgeInsets.only(bottom: 10),
    child: Text(
      "$buttonText",
      style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    ),
  );
}
Widget getAwesomeButton(String text,Function function)
{
return  Container(
  margin: EdgeInsets.only(top: 32.0),
  width: double.infinity,
  child: RaisedButton(
    color: Colors.red,
    textColor: Colors.white,
    elevation: 5.0,
    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
    child: Text(
      '$text',
      style: TextStyle(fontSize: 16.0),
    ),
    onPressed: () {
      function();
      //if (_keyValidationForm.currentState.validate()) {
      //  _onTappedButtonRegister();
      //}
    },
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0)),
  ),
); //button: login
}