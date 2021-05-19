import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/screens/ListOfServiceHistory.dart';
import 'package:bigmidasvendor/screens/ListOfVichleHistory.dart';
import 'package:bigmidasvendor/screens/dashboard.dart';
import 'package:bigmidasvendor/screens/listing.dart';
import 'package:bigmidasvendor/sharedpreference/tempprefmimicapi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget getDashboardOption(String textString,String imageLocation,BuildContext context,double imageSize)
{
Size size=MediaQuery.of(context).size;
 return GestureDetector(
     onTap: ()async{
       TempPrefMimicAPI tempPrefMimicAPI=TempPrefMimicAPI();
       ModalPrefListingStatus modal=await tempPrefMimicAPI.getUserPreference();
       if(textString=="Store Listing")
       {
         Provider.of<ProviderLogin>(context,listen: false).userType="store";
         print(Provider.of<ProviderLogin>(context,listen: false).modelUser.toString());


         if(Provider.of<ProviderLogin>(context,listen: false).modelUser.vendor[0].isshoplisted=="1"||
             (modal!=null&&modal.storeListed!=null&&modal.storeListed))
           Navigator.pushNamed(context, DashBoard.routeName);
           else
         Navigator.pushNamed(context, Listing.routeName,arguments: 1);
       }
       else if(textString=="Vehicle Listing")
         {
           print("clcked vehicle listing");
           Provider.of<ProviderLogin>(context,listen: false).userType="vehicle";
           if(Provider.of<ProviderLogin>(context,listen: false).modelUser.vendor[0].isvehiclelisted=="1"||
               (modal!=null&&modal.vehicleListed!=null&&modal.vehicleListed))
             {
               print("true");
               Navigator.pushNamed(
                              context, ListOfVichleHistory.routeName);
             }
           else
           Navigator.pushNamed(context, Listing.routeName,arguments: 2);
         }
       else
         {
           Provider.of<ProviderLogin>(context,listen: false).userType="service";
           if(Provider.of<ProviderLogin>(context,listen: false).modelUser.vendor[0].isservicelisted=="1"||
               (modal!=null&&modal.serviceListed!=null&&modal.serviceListed))
             {
               Navigator.pushNamed(context, ListOfServiceHistory.routeName);
             }
           else
           Navigator.pushNamed(context, Listing.routeName,arguments: 3);
         }
     },
     child: Container(


   height: 130,
   width: size.width/2,
   decoration: BoxDecoration(

       border: Border.all(color: Colors.black,width: 1),
       borderRadius: BorderRadius.all(Radius.circular(10))
   ),
   child:Column(children: [
     Container(
       margin: EdgeInsets.only(top: 10),
       child: Image.asset(imageLocation,height: imageSize,width: imageSize,),),
      Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(textString),)

   ],
   ) ,
     )
 );
}