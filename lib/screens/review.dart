
import 'dart:convert';

import 'package:bigmidasvendor/model/modalshopreview.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:bigmidasvendor/widgets/reviewcard.dart';
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../common.dart';

class ReviewListView extends StatefulWidget {
  static String routeName="/review";
  @override
  _ReviewListStateView createState() => _ReviewListStateView();
}

class _ReviewListStateView extends State<ReviewListView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ModalShopReview> listReviews;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userType = Provider
        .of<ProviderLogin>(context, listen: false)
        .userType;
    print("review initstate user type $userType");
    if(userType=="store"){
      getStoreReview(REVIEW_URL_STORE);
    }
    else if(userType=="service")
      {
        getStoreReview(REVIEW_URL_SERVICE);
      }
    else
      {
        getStoreReview(REVIEW_URL_VEHICLE);
      }
  }
  @override
  Widget build(BuildContext context) {
    String reviewTitle="Review on your store:";
    print(Provider.of<ProviderLogin>(context,listen: false).userType);
    if(Provider.of<ProviderLogin>(context,listen: false).userType=="vehicle")
      reviewTitle="Review on your Vehicle:";
    else if(Provider.of<ProviderLogin>(context,listen: false).userType=="service")
      reviewTitle="Review on your Service:";
    return Scaffold(
        key: _scaffoldKey,
      // drawer: drawer(context, "username", "balance"),
      drawer: TestDraw(),

        appBar: getAppBar(_scaffoldKey,context),
        body: listReviews==null
            ?Center(child: CircularProgressIndicator(),)
            :listReviews.length==0
            ?Center(child: Text("No Reviews at this moment",style: TextStyle(fontSize:20,color: Colors.red ),),)
            :Container(
      margin: EdgeInsets.only(top: 30),
        child: ListView(

          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: InkWell(
                  onTap: () => {
                    // Navigator.pushNamed(context, '/storeProfile')
                    print("Add review")
                  },
                  child: Text("$reviewTitle",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
              ),
            ),

            for(int i=0;i<listReviews.length;i++)
            ReviewCard(
              name: "${listReviews[i].customer}",
              rating: listReviews[i].rating,
              review: listReviews[i].review,
            ),
//
//            ReviewCard(
//              name: "carMellta Marsham",
//              rating: 5,
//              review: '"Recently cruised on Princess line for the first time"',
//            ),
//            ReviewCard(
//              name: "Igor Antonovich",
//              rating: 2,
//              review: '"There is a huge variety of water sports',
//            ),
//            ReviewCard(
//              name: "Igor Antonovich",
//              rating: 4,
//              review: '"There is a huge variety of water sports',
//            ),
//            ReviewCard(
//              name: "Igor Antonovich",
//              rating: 1,
//              review: '"There is a huge variety of water sports',
//            ),
//            ReviewCard(
//              name: "Igor Antonovich",
//              rating: 4,
//              review: '"There is a huge variety of water sports',
//            )
          ],
        )
      // child: ListView(
      //   children: [
      //     Text("hi"),
      //     Text("hi"),

      //   ],
      // ),
    )
    );
  }

  void getStoreReview(String respectiveUrl)async {

    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url=respectiveUrl+"/"+vendorId;
    print("Get reviews $url");
    var request = http.Request('GET', Uri.parse(url));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes=await response.stream.bytesToString();
      print(strRes);
      List<dynamic>list=jsonDecode(strRes);
      listReviews=List();
      for(int i=0;i<list.length;i++)
        {
          listReviews.add(ModalShopReview.fromJson(list[i]));
        }
      setState(() {

      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}