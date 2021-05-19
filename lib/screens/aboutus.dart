import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class AboutUs extends StatefulWidget {

  static String routeName = "/aboutus";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutUsState();
  }
}
class AboutUsState extends State<AboutUs>{
  var aboutUs;

  int content;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      content= ModalRoute.of(context).settings.arguments;
      getData();
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("BigMidas"),backgroundColor: Colors.deepOrangeAccent,),
        body: Center(
            child:
            Padding(padding: EdgeInsets.all(15),
                child: Column(
                    children:[
                      SizedBox(
                          height: 60
                      ),
                      content==0?Text("About Us", style: TextStyle( fontSize: 30, fontWeight: FontWeight.w800 ),):Container(),
                      content==1?Text("Terms And Conditions", style: TextStyle( fontSize: 30, fontWeight: FontWeight.w800 ),):Container(),
                      content==2?Text("Privacy", style: TextStyle( fontSize: 30, fontWeight: FontWeight.w800 ),):Container(),
                      SizedBox(
                          height: 50
                      ),
                     aboutUs==null?Container(margin: EdgeInsets.only(top: 10),child: CircularProgressIndicator(),): Text("$aboutUs", style: TextStyle(fontSize: 15, color: Colors.black)),
                    ]
                )
            )
        )
    );
    throw UnimplementedError();
  }

  void getData()async {
    var request = http.Request('GET', Uri.parse('https://admin.bigmidas.com:7420/store/getvendorpages'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes=await response.stream.bytesToString();
      print(strRes);
      List<dynamic>list = json.decode(strRes);
      print("list json decode $list");
      print("list json decode ${list.length}");

      for (int i = 0; i < list.length; i++){
        print(list[i]);


        if(content==0&&list[i]['page_name'].toString().contains("About"))
          aboutUs=list[i]['description'];
        if(content==1&&list[i]['page_name'].toString().contains("Terms1"))
          aboutUs=list[i]['description'];
        if(content==2&&list[i]['page_name'].toString().contains("Privacy"))
          aboutUs=list[i]['description'];
      }
      setState(() {

      });
      print("about us content is $aboutUs $content");

    }
    else {
    print(response.reasonPhrase);
    }

  }
}