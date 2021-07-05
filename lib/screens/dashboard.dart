import 'package:bigmidasvendor/model/modalmycurrentsubs.dart';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providersubscriptionplan.dart';
import 'package:bigmidasvendor/screens/editproduct.dart';
import 'package:bigmidasvendor/screens/subscription.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:bigmidasvendor/widgets/vehicleorders.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'ListOfHistory.dart';

class DashBoard extends StatefulWidget
{
  static String routeName="/dashboard";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardState();
  }
}
class DashboardState extends State<DashBoard>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlans();

  }
 void getPlans()async {
   LoginPreference pref=LoginPreference();
   ModelUser modelUser=await pref.getUserPreference();
   Provider.of<ProviderSubscriptionPlans>(context,listen: false).getMyCurrentSubscription(modelUser.sId,context);

 }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     ModalMySubs modalMySubs=Provider.of<ProviderSubscriptionPlans>(context,listen:true).modalMySubs;
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      // drawer: drawer(context,"Mohit","100"),
      drawer: TestDraw(),
      appBar: getAppBar(_scaffoldKey,context),
      body: getDashboardDataDependingOnCategory(context),
    );
  }
}

Widget getDashboardDataDependingOnCategory(BuildContext context) {

   ModalMySubs modalMySubs=Provider.of<ProviderSubscriptionPlans>(context,listen:true).modalMySubs;
  String userType = Provider
      .of<ProviderLogin>(context)
      .userType;
//  if (userType == "store") {
  if(true){
    // getPlans();
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(onTap: ((){
                    Share.share('Checkout the Bigmidas Vendor app to list your Vehicle and get orders online you can also list your Store & Services as well https://play.google.com/store/apps/details?id=bigmidas');
                  }),
                  child: Container(child: Image.asset("assets/images/share1.jpeg",height: 80,width: 80,),),),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Membership"),
            SizedBox(width: 20,),
                                 InkWell(
                      onTap: (){Navigator.pushNamed(context, Subscription.routeName);},
                      child:
            Container(

              margin: EdgeInsets.only(right: 10),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)

                ),
                border: Border.all(
                  width: 3,
                  color: Colors.red,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: modalMySubs==null||modalMySubs.daysremaining==null
                    ?Container(child: CircularProgressIndicator(),)
                    :modalMySubs.daysremaining==-10?Text("0"):Text(
                  "${modalMySubs.daysremaining}",
                ),
              ),
            ),
            )

          ],

        ),
      ],),

      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        getDashboardOption("All Orders", "assets/images/allorders.png", context),

        getDashboardOption("Pending Orders", "assets/images/pendingorders.png", context),
      ],),
      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getDashboardOption("Confirmed Orders", "assets/images/confirmedorder.png", context),

          getDashboardOption("Delivered Orders", "assets/images/delivered.jpg", context),
        ],),
      SizedBox(height: 20,),
      userType!="store"?Container():
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getDashboardOption("Total Products", "assets/images/allorders.png", context),

        ],)
    ],
    );
  }
  else
    {
//      Navigator.pushn
//      return Container();
      return Column(children: <Widget>[

          vehicleOrder(),
      vehicleOrder(),
      vehicleOrder(),
      ],
      );
      return Column(children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
         Container(
           margin: EdgeInsets.only(top: 20),
           child: Text("Your Bookings",style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),),),
         SizedBox(width: 20,),
         Container(
           height: 30, width: 30,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(50), color: Colors.red),),
       ],),

        Container(
          margin: EdgeInsets.all(20),
          padding:  EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(10),),border: Border.all(color: Colors.red) ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Pending"),
            Text("Confirmed")
          ],),)

      ],
      );
    }
}

  Widget getDashboardOption(String textString,String imageLocation,BuildContext context)
  {
    Size size=MediaQuery.of(context).size;
    return GestureDetector(
        onTap: (){


          if(textString=="Total Products")
            Navigator.pushNamed(context, EditProduct.routeName,arguments: textString);
          else
            Navigator.pushNamed(context, ListOfHistory.routeName,arguments: textString);
        },
        child: Container(


          height: 100,
          width: size.width/2-50,
          decoration: BoxDecoration(

              border: Border.all(color: Colors.black,width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child:Column(children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Image.asset(imageLocation,height: 50,width: 50,),),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(textString),)

          ],
          ) ,
        )
    );
  }

