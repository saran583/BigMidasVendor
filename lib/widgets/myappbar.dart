import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/screens/location.dart';
import 'package:bigmidasvendor/screens/notification.dart';
import 'package:bigmidasvendor/screens/tutorial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget getAppBar(_scaffoldKey,context)
{
  return AppBar(
backgroundColor: Colors.deepOrangeAccent,
    leading:GestureDetector(
      onTap: (){_scaffoldKey.currentState.openDrawer();},
      child: Container(
        height: 10,width: 10,
        child: Image.asset("assets/images/menuitem.jpg",height: 10,width: 10,
        ),
      ),
    ),
    actions: [


    GestureDetector(
      onTap: (){
        print("question mark clicked ");
        Navigator.pushNamed(context, Tutorial.routeName);
      },
      child:  Image.asset("assets/images/question.png",height: 30,width: 30,) ,),
      SizedBox(width: 20,),
      if(Provider.of<ProviderLogin>(context, listen: false).userType!="vehicle")
      GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, LocationDetails.routeName);
      },
      child: Container(
        child: Image.asset("assets/images/location.png",height: 30,width: 30,),
      ) ,
    ),
      if(Provider.of<ProviderLogin>(context, listen: false).userType!="vehicle")
      SizedBox(width: 20,),
    GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppNotification.routeName);
      },
      child: Container(
        child: Image.asset("assets/images/notification.png",
          height: 30,
          width: 30,),
        margin: EdgeInsets.only(right: 20),
      ) ,
    )
    ],
    title: Text("Brand",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
  );
}