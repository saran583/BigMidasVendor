import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/model/modalmycurrentsubs.dart';
import 'package:bigmidasvendor/model/modalsubplan.dart';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providersubscriptionplan.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:bigmidasvendor/widgets/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Subscription extends StatefulWidget
{
  static String routeName="/subscription";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SubscriptionState();
  }
}
class SubscriptionState extends State<Subscription>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoadingPlans=true;

  ModalMySubs modalMySubs;
  Razorpay _razorpay;
  String selectedPlanId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

        getPlans();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  @override
  Widget build(BuildContext context) {
    List<ModalSubsPlans> listModalSubsPlans=Provider.of<ProviderSubscriptionPlans>(context,listen: true).listModalSubsPlans;
    modalMySubs=Provider.of<ProviderSubscriptionPlans>(context,listen:true).modalMySubs;
    // TODO: implement build
    ModalSubsPlans item;
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(_scaffoldKey,context),
      drawer: drawer(context, "username", "balance"),
      body: listModalSubsPlans==null
          ?Center(child: CircularProgressIndicator(),)

          :Container(

        
        margin: EdgeInsets.only(top: 40),
        child:Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Text("Your Current Subscription",style: TextStyle(color: Colors.black,fontSize: 18),),
            Text("${modalMySubs!=null?modalMySubs.daysremaining<0?"0":modalMySubs.daysremaining:"0"} Days",style: TextStyle(color: Colors.red,fontSize: 18),),
          ],
          ),
          SizedBox(height: 10,),
          Container(
              alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30,right: 30,top: 50),
              child: Text("Reactivate Your Account:",style: TextStyle(color: Colors.blue,fontSize: 20),),),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left:40 ,top: 10),
            child: Text("To Get Orders:",style: TextStyle(color: Colors.blue,fontSize: 20),),),

        for(int i=0;i<listModalSubsPlans.length;i++)
          Container(
              margin: EdgeInsets.all(10),
              child: Container(
                height: 50,
                child: Card(child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [


       Text(listModalSubsPlans[i].days.toString(),style: TextStyle(color: Colors.black,fontSize: 18),),
      Text(listModalSubsPlans[i].cost.toString(),style: TextStyle(color: Colors.black,fontSize: 18),),
      GestureDetector(onTap: (){
        selectedPlanId=listModalSubsPlans[i].sId;
        var options = {
          'key': 'rzp_test_gND9DtvkDMNptz',
          'amount': listModalSubsPlans[i].cost*100,
          'name': 'Big midas',
          'description': 'Subscription',
          'prefill': {
            'contact': '8888888888',
            'email': 'test@razorpay.com'
          }
        };
        _razorpay.open(options);

      },
          child:  Text("Pay Now",style: TextStyle(color: Colors.blue,fontSize: 18),)),
   ] ),
//                    Text("30 Days:",style: TextStyle(color: Colors.black,fontSize: 18),),
//                    Text("100 Rs.",style: TextStyle(color: Colors.red,fontSize: 18),),
//                    Text("Pay Now",style: TextStyle(color: Colors.blue,fontSize: 18),),

                ),
              ),
          )

//          Container(
//              margin: EdgeInsets.all(10),
//              child: Container(
//                height: 50,
//                child: Card(child: Row(
//
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: [
//                  Text("30 Days:",style: TextStyle(color: Colors.black,fontSize: 18),),
//                  Text("100 Rs.",style: TextStyle(color: Colors.red,fontSize: 18),),
//                  Text("Pay Now",style: TextStyle(color: Colors.blue,fontSize: 18),),
//                ],
//              ),),)
//          ),
//
//          Container(
//
//            margin: EdgeInsets.all(10),
//            child:Card(
//              child:  Container(
//                height: 50,
//                child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: [
//                  Text("90 Days:",style: TextStyle(color: Colors.black,fontSize: 18),),
//                  Text("250 Rs.",style: TextStyle(color: Colors.red,fontSize: 18),),
//                  Text("Pay Now",style: TextStyle(color: Colors.blue,fontSize: 18),),
//                ],
//              ),
//              )
//            )
//          ),
//
//          Container(
//            margin: EdgeInsets.all(10),
//            child: Container(
//              height: 50,
//              child: Card(child: Row(
//
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: [
//                Text("180 Days:",style: TextStyle(color: Colors.black,fontSize: 18),),
//                Text("450 Rs.",style: TextStyle(color: Colors.red,fontSize: 18),),
//                Text("Pay Now",style: TextStyle(color: Colors.blue,fontSize: 18),),
//              ],
//            ),
//              ),
//            )
//          ),
//
//          Container(
//              margin: EdgeInsets.all(10),
//              child: Container(
//                height: 50,
//                child: Card(child: Row(
//
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: [
//                  Text("365 Days:",style: TextStyle(color: Colors.black,fontSize: 18),),
//                  Text("800 Rs.",style: TextStyle(color: Colors.red,fontSize: 18),),
//                  Text("Pay Now",style: TextStyle(color: Colors.blue,fontSize: 18),),
//                ],
//              ),),)
//          ),

          

            ],
            ),
          ),


    );
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    // Do something when payment succeeds
    getCustomDialog(context, "Action Completed"," Payment Successfull",DialogType.INFO);
    print("subscription payment success");
    Provider.of<ProviderSubscriptionPlans>(context,listen: false).updatePlan(context,selectedPlanId,"success");
    // List<ModalSubsPlans> listModalSubsPlans=Provider.of<ProviderSubscriptionPlans>(context,listen: true).listModalSubsPlans;
      LoginPreference pref=LoginPreference();
      ModelUser modelUser=await pref.getUserPreference();
    var value = Provider.of<ProviderSubscriptionPlans>(context,listen: false).getupdatedSubscription(modelUser.sId,context);
    setState(() {
          getPlans();
        });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    getCustomDialog(context, "Error"," Payment Un-Sucessfull",DialogType.ERROR);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  void getPlans()async {
    print("Logged in");
    LoginPreference pref=LoginPreference();
      ModelUser modelUser=await pref.getUserPreference();
    Provider.of<ProviderSubscriptionPlans>(context,listen: false).getMyCurrentSubscription(modelUser.sId,context);
    // modalMySubs=Provider.of<ProviderSubscriptionPlans>(context,listen:true).modalMySubs;
    
  Provider.of<ProviderSubscriptionPlans>(context,listen: false).getPlans(context);
    setState(() {
      isLoadingPlans=false;
    });
    // setState(() {
          
    //     });
  }

}