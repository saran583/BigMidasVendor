import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:bigmidasvendor/common.dart';
import 'package:http/http.dart'as http;
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

import 'listtiledrawer.dart';


class TestDraw extends StatefulWidget{
  @override
  TestDrawState createState()=> TestDrawState();
  
}

class TestDrawState extends State<TestDraw>{
  ModelUser modelUser;
    bool value;
    List<Icon>icons=[
  Icon(Icons.account_circle),
  Icon(Icons.book),
  Icon(Icons.rate_review),
  Icon(Icons.subscriptions),
  Icon(Icons.share),
  Icon(Icons.label_outline),
  Icon(Icons.branding_watermark),
  Icon(Icons.bookmark_border),
  Icon(Icons.call_missed_outgoing),
  Icon(Icons.account_circle),
  Icon(Icons.account_circle),
  Icon(Icons.account_circle),
];

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    if(Provider.of<ProviderLogin>(context,listen:false).userType=="store"){
    getstatus("","store");
    }
    else if(Provider.of<ProviderLogin>(context,listen:false).userType=="vehicle"){
      print("vehicle");
    getstatus("","vehicle");
    }
    else if(Provider.of<ProviderLogin>(context,listen:false).userType=="service"){
      print("service");
    getstatus("","service");
    }
  }
  void getPref() async{
    LoginPreference pref= LoginPreference();
    modelUser= await pref.getUserPreference();
    print(" model user is $modelUser.sId");
  }

  @override
  Widget build(BuildContext context){
    // bool value;
    // bool value;
    // setState(() async {
           
        // });
    // TODO: implement build
   return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      
      child: Drawer(
          child: Container(
            margin: EdgeInsets.only(left: 20,top: 40),
            child: ListView(
            children: [
            Container(
              margin: EdgeInsets.only(left:0,right: MediaQuery.of(context).size.width/4+55),
              height: 30,
              child: 
            // Row(children: [
              // Text("Active", style: TextStyle(color: Colors.red,fontSize: 22
              //  ),),
              //  SizedBox(width: 25,),
            //   CustomSwitch(
            //   activeColor: Colors.pinkAccent,
            //   value: value,
            //   onChanged: (status) {
            //     print("VALUE : $value");
            //       if(Provider.of<ProviderLogin>(context,listen:false).userType=="store"){
            //        editstatus("modelUser.sId",status,"store");
            //        print("New state $status");
            //         //  value = status;
            //       }
            //       if(Provider.of<ProviderLogin>(context,listen:false).userType=="vehicle"){
            //       // value = value;
            //       editstatus("modelUser.sId",status,"vehicle");
            //        print("New state $status");
            //       }
            //       if(Provider.of<ProviderLogin>(context,listen:false).userType=="store"){
            //       // value = value;
            //       editstatus("modelUser.sId",status,"service");
            //        print("New state $status");
            //       }
            //   },
            // ),

           value==null?Text("Loading..."):LiteRollingSwitch(


               //initial value
               value: value,
               textOn: 'Active',
               textOff: 'In-Active',
               colorOn: Colors.greenAccent[700],
               colorOff: Colors.redAccent[700],
               iconOn: Icons.done,
               iconOff: Icons.remove_circle_outline,
               textSize: 12.0,
               onChanged: (status) {
                print("VALUE : $value");
                  if(Provider.of<ProviderLogin>(context,listen:false).userType=="store"){
                   editstatus("modelUser.sId",status,"store");
                   print("New state $status");
                    //  value = status;
                  }
                  if(Provider.of<ProviderLogin>(context,listen:false).userType=="vehicle"){
                  // value = value;
                  editstatus("modelUser.sId",status,"vehicle");
                   print("New state $status");
                  }
                  if(Provider.of<ProviderLogin>(context,listen:false).userType=="service"){
                  // value = value;
                  editstatus("modelUser.sId",status,"service");
                   print("New state $status");
                  }
              },
             ),



            // SizedBox(width: 20,)
            // ],)
            ),
            SizedBox(height: 40,),

            Image.asset("assets/images/logo_Big_Midas.jpeg",height: 120,width: 120,),
            //for(var item in Provider.of<ProviderLogin>(context).getDrawerOptions() )
              for(int i=0;i< Provider.of<ProviderLogin>(context).getDrawerOptions().length;i++ )
              DrawerTile(context,Provider.of<ProviderLogin>(context).getDrawerOptions()[i],icons[i])



          ],) ,), ),);
 



}

editstatus(val,state,cat) async {
   var url;
    LoginPreference pref= LoginPreference();
    modelUser= await pref.getUserPreference();

   if(cat=="store"){
    url = EDITSTOREACTIVE+"/"+modelUser.sId+"&&"+state.toString();
  }
  else if(cat=="service"){
    url = EDITSERVICEACTIVE+"/"+modelUser.sId+"&&"+state.toString();
  }
  else if(cat=="vehicle"){
    url = EDITVEHICLEACTIVE+"/"+modelUser.sId+"&&"+state.toString();
  }
  // var url = EDITSTOREACTIVE+"/"+val+state.toString();
  var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
    print(response);
    setState(() {
          value=state;
        });
  return true;
} 


  // getstatus(String sId, String s) {
  Future<bool> getstatus(String val, String cat) async {
  print("Entered getstatus");
   var url;
   LoginPreference pref= LoginPreference();
    modelUser= await pref.getUserPreference();
   if(cat=="store"){
     print("entered store in get status");
    url = GETSTOREACTIVE+"/"+modelUser.sId;
  }
  else if(cat=="service"){
    url = GETSERVICEACTIVE+"/"+modelUser.sId;
  }
  else if(cat=="vehicle"){
    url = GETVEHICLEACTIVE+"/"+modelUser.sId;
  }
  var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
    String strRes=await response.stream.bytesToString();
    print("this is response from drawer $strRes");

    if(strRes.contains("true")){
      print("Status is true in drawer");
      setState(() {
              value=true;
            });
      return true;
    }
    else if(strRes.contains("false")){
      print("Status is false in drawer");
      setState(() {
              value=false;
            });

    }
  
}
  }