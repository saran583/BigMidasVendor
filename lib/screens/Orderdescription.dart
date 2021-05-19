import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Orderdescription extends StatefulWidget{
  static String routeName="/orderdescription";
  @override
  State<StatefulWidget> createState() {
    return OrderdescriptionState();
  }

}

class OrderdescriptionState extends State<Orderdescription> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async{
    print(ModalRoute.of(context).settings.arguments);
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          key: _scaffoldKey,
          appBar: getAppBar(_scaffoldKey,context),
          drawer: drawer(context, "username", "balance"),
          //body:modelShopOrders==null||modelShopOrders.products==null?Center(child: CircularProgressIndicator(),):Container(
          body:Container(child: Center(child: Text("Hello"),)));
    
  }

}

