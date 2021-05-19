import 'dart:convert';

import 'package:bigmidasvendor/model/modalvideos.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../common.dart';
class Tutorial extends StatefulWidget
{
  static String routeName="/tutorial";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TutorialState();
  }
}
class TutorialState extends State<Tutorial>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int showDetails = 0;

  List<ModelVideos> listModelVideos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideos(VENDOR_VIDEOS);
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
      appBar: getAppBar(_scaffoldKey, context),
      drawer: drawer(context,"Mohit","100"),
      body:  SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20,left: 20),
            child:Text("How to use the App Tutorial",style: TextStyle(color: Colors.red,fontSize: 18),),),

          listModelVideos==null?Center(child: CircularProgressIndicator(),):
          listModelVideos.length==0?Container(child: Text("No Videos Found"),):
          Container(
            height: size.height-100,
            child: ListView(children: [
            for(int i=0;i<listModelVideos.length;i++)
              getWidgetVideo(listModelVideos[i]),
          ],
          ),)

        ],
      ),)
    );

  }

  void getVideos(String url) async{

    print("get vide $url");
    var request = http.Request('GET', Uri.parse(url));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
      listModelVideos = List();
      List<dynamic>list = json.decode(strResponse);
      for (int i = 0; i < list.length; i++){
        print(list[i]);
        listModelVideos.add(ModelVideos.fromJson(list[i]));
      }
      setState(() {

      });

    }
    else {
      print(response.reasonPhrase);
    }

  }

 Widget getWidgetVideo(ModelVideos modelvideo) {
    //listModelVideos=null;
//    setState(() {
//
//    });
    if(!modelvideo.url.contains("="))return Container();
    String videoId=modelvideo.url.split("=")[1];
    String videoThumbnail="https://img.youtube.com/vi/$videoId/0.jpg";
    return  GestureDetector(onTap: ()async{
      print("onclicked");
      print("${await canLaunch('${modelvideo.url}')}");
//      if (await canLaunch('youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
//      await launch('youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw', forceSafariVC: false);
      if (await canLaunch('${modelvideo.url}')) {
        await launch('${modelvideo.url}', forceSafariVC: false);
      }
    },child: Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child:Row(children: [
        //Image.asset("assets/images/download.jpg",height: 150,width: 150,),
        Image.network(videoThumbnail,height: 150,width: 150,),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text("${modelvideo.name}",style: TextStyle(fontSize: 20),
          ),
        )
      ],
      ) ,
    ),);
  }
}