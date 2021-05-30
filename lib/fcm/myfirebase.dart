import 'dart:io';
// import 'dart:js';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../common.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
 String firebaseToken;
 void setupFirebase()
{
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  var android = new AndroidInitializationSettings(
      '@mipmap/ic_launcher');
  //var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  var iOS = new IOSInitializationSettings();
  var initSetttings = new InitializationSettings(android, iOS);
  flutterLocalNotificationsPlugin.initialize(initSetttings,
      onSelectNotification: onSelectNotification);

}

void initFirebase(context){
  firebaseCallBacks(context);

}
firebaseCallBacks(context) {
  print("firebasecallbacks");
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage=============: $message");
      String title, body, screen, imageUrl, subTitle, notificationId;
      message.forEach((key, value) {
        print(key);
        if (key == "notification") {
          title = value['title'];
          body = value['body'];
        }
        if (key == "data") {
          screen = value['screen'];
          imageUrl = value['image'];
          subTitle = value['subtitle'];
          if (value['notification_id'] != null)
            notificationId = value['notification_id'];
          else
            notificationId = "333";
        }
        print(value);
      });
      print("title $title");
      print("body $body");
      print("screen $screen");
      print("screen $imageUrl");
      showNotification(0, title, body,
          payload: screen, imageURL: imageUrl, subTitle: subTitle);
    },
    onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch========================: $message");

      String title, body, screen, notificationId;
      message.forEach((key, value) {
        print(key);
        if (key == "notification") {
          title = value['title'];
          body = value['body'];
        }
        if (key == "data") {
          screen = value['screen'];
          if (value['notification_id'] != null)
            notificationId = value['notification_id'];
          else
            notificationId = "333";
        }
        print(value);
      });
      print("title $title");
      print("body $body");
      print("screen $screen");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume========== : $message");
      String title, body, screen, notificationId;
      message.forEach((key, value) {
        print(key);
        if (key == "notification") {
          title = value['title'];
          body = value['body'];
        }
        if (key == "data") {
          screen = value['screen'];
          if (value['notification_id'] != null)
            notificationId = value['notification_id'];
          else
            notificationId = "333";
        }
        print(value);
      });
      print("title $title");
      print("body $body");
      print("screen $screen");
      // Navigator.pushReplacementNamed(
      //     navigatorKey.currentState.context, screen,
      //     arguments: false);

      //print("on resume firebase")
      // _navigateToItemDetail(message);
    },
  );

  _firebaseMessaging.getToken().then((String token) {
    assert(token != null);
    //setState(() {
    firebaseToken = token;

    insertToken(token,context);
  });
  _firebaseMessaging.onTokenRefresh.listen((event) {
    print("token updated " + event);
  });
}

showNotification(int id, String title, String body,
    {String payload, String imageURL, String subTitle}) async {
  var attachmentPicturePath = imageURL != null
      ? await _downloadAndSaveFile(imageURL, 'attachment_img.jpg')
      : null;
  var bigPictureStyleInformation = imageURL != null
      ? BigPictureStyleInformation(
    FilePathAndroidBitmap(attachmentPicturePath),
    contentTitle: '$title',
    summaryText: '$body',
  )
      : null;
  if (subTitle == null || subTitle.isEmpty) subTitle = "";
  var biTextStyleInformation =
  BigTextStyleInformation(body, contentTitle: title, summaryText: subTitle);
  var android = new AndroidNotificationDetails(
    'akiakiBudyloan',
    'Buddy Loan',
    'This is buddyloan local notifier',
    importance: Importance.Max,
    styleInformation:
    imageURL != null ? bigPictureStyleInformation : biTextStyleInformation,
  );
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(android, iOS);
  await flutterLocalNotificationsPlugin.show(id, title, body, platform,
      payload: payload);
}


void insertToken(String token,context) async{

  var uri =Uri.parse(TOKENURL);
  String deviceId= await getAndroidDeviceId();
//  print("uri=================" + uri.toString());
//  var _request = new http.MultipartRequest("POST", uri)
//    ..fields['token'] =token
//    ..fields['device_id']=deviceId;
//  print("token request"+_request.fields.toString());
//  var response = await _request.send();
//
//  print("insert token is ${await response.stream.bytesToString()}");
  String vendorId="";
  ModelUser modelUser=Provider.of<ProviderLogin>(context,listen:false).modelUser;
  if(modelUser!=null)
   vendorId=modelUser.sId;
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request('POST', uri);
  request.bodyFields = {
    'firebase_token': token,
    'device_id': deviceId,
    'uid':vendorId
  };
  print("request ${request.bodyFields.toString()}");
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}

Future<String> getAndroidDeviceId() async {
  String deviceId = "";
  DeviceInfoPlugin deviceInfo = await DeviceInfoPlugin();
  print("platform  " + Platform.operatingSystem);
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    deviceId = androidInfo.androidId + ":" + androidInfo.id;
  } // e.g. "Moto G (4)"
  return deviceId;
}

_downloadAndSaveFile(String url, String fileName) async {
  var directory = await getApplicationDocumentsDirectory();

  var filePath = '${directory.path}/$fileName';
  var response = await http.get(url);
  var file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future onSelectNotification( String payload) {
  BuildContext context;
  debugPrint("payload : $payload");
  Navigator.pushNamed(context,payload);
  print("pushed to screen");
  //navigationForBothNotificationanddeepLink(payload);
  // Navigator.pushReplacementNamed(navigatorKey.currentState.context, "/"+payload,
      // arguments: false);
  // showDialog(
  //   context: context,
  //   builder: (_) => new AlertDialog(
  //     title: new Text('Notification'),
  //     content: new Text('$payload'),
  //   ),
  // );
}
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print(message.toString());
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print("app background captured data");
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
}
