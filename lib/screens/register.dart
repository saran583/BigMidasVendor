import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/widgets/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'dart:math' as math;


class RegisterScreen extends StatefulWidget {
  static String routeName="/register";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static var _keyValidationForm = GlobalKey<FormState>();
//  TextEditingController _textEditConName = TextEditingController(text: "Guna");
//  TextEditingController _textEditConEmail = TextEditingController(text:"gunasri1@gmail.com");
//  TextEditingController _textEditConPassword = TextEditingController(text: "123456");
//  TextEditingController _textControllerphone = TextEditingController(text:"1234567890");
//  TextEditingController _textControllerotp = TextEditingController(text: "1234");

  TextEditingController _textEditConName = TextEditingController(text: "");
  TextEditingController _textEditConEmail = TextEditingController(text:"");
  TextEditingController _textEditConPassword = TextEditingController(text: "");
  TextEditingController _textControllerphone = TextEditingController(text:"");
  TextEditingController _textControllerotp = TextEditingController(text: "");
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading=false;
  bool otpVerified;
  String otpSent="";

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //isLoading=false;
    return Scaffold(
      backgroundColor: Colors.white,

      //backgroundColor: AppColors.colorGrey,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Column(
              children: <Widget>[
                getWidgetImageLogo(),
                getWidgetRegistrationCard(),
              ],
            )),
      ),
    );
  }

  Widget getWidgetImageLogo() {
    return Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 32),
          child: Image.asset("assets/images/logo_Big_Midas.jpeg",height: 180,width: 180,),
        ));
  }

  Widget getWidgetRegistrationCard() {
//    final FocusNode _passwordEmail = FocusNode();
//    final FocusNode _passwordFocus = FocusNode();
//    final FocusNode _passwordConfirmFocus = FocusNode();

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _keyValidationForm,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black),
                  ),
                ), // title: login
                Container(
                  child: TextFormField(
                    controller: _textEditConName,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: _validateUserName,
                    onFieldSubmitted: (String value) {
                     // FocusScope.of(context).requestFocus(_passwordEmail);
                    },
                    decoration: InputDecoration(
                        labelText: 'Full name',
                        //prefixIcon: Icon(Icons.email),
                        icon: Icon(Icons.perm_identity)
                    ),
                  ),
                ), //text field : user name
                Container(
                  child: TextFormField(
                    controller: _textEditConEmail,
                  //  focusNode: _passwordEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: _validateEmail,
                    onFieldSubmitted: (String value) {
                     // FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        //prefixIcon: Icon(Icons.email),
                        icon: Icon(Icons.email)),
                  ),
                ), //text field: email
                Container(
                  child: TextFormField(
                    controller: _textControllerphone,
                    //focusNode: _passwordEmail,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: _validatePhone,
                    onFieldSubmitted: (String value) {
                     // FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        //prefixIcon: Icon(Icons.email),
                        icon: Icon(Icons.phone)),
                    onChanged: (value){
                      print(value);
                      if(value.length==10){
                        sendOtp(value);
                      }
                    },
                  ),
                ), //text field: email
                Container(
                  child: TextFormField(
                    controller: _textControllerotp,
                 //   focusNode: _passwordFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: _validateOtp,
                    onFieldSubmitted: (String value) {
                    //  FocusScope.of(context)
                   //       .requestFocus(_passwordConfirmFocus);
                    },
                    //obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                        labelText: 'OTP',
//                        suffixIcon: IconButton(
//                          icon: Icon(isPasswordVisible
//                              ? Icons.visibility
//                              : Icons.visibility_off),
//                          onPressed: () {
//                            setState(() {
//                              isPasswordVisible = !isPasswordVisible;
//                            });
//                          },
//                        ),
                        icon: Icon(Icons.vpn_key)),
                  ),
                ), //text field: password
                Container(
                  child: TextFormField(
                      controller: _textEditConPassword,
                     // focusNode: _passwordConfirmFocus,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: _validatePassword,
                      obscureText: !isConfirmPasswordVisible,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                              });
                            },
                          ),
                          icon: Icon(Icons.vpn_key))),
                ),
            isLoading?Container(margin: EdgeInsets.only(top: 10),child: CircularProgressIndicator(),):Container(
                  margin: EdgeInsets.only(top: 32.0),
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 5.0,
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onPressed: () {

                      print("validate form ${_keyValidationForm.currentState.validate()}");
                      if (_keyValidationForm.currentState.validate()) {
                        _onTappedButtonRegister();

                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                ), //button: login
                Container(
                    margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already Register? ',
                        ),
                        InkWell(
                          splashColor: Colors.red,
                          onTap: () {
                            //_onTappedTextlogin();
                            Navigator.pushReplacementNamed(context, Login.routeName);
                          },
                          child: Text(
                            ' Login',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _validateUserName(String value) {
    return value.trim().isEmpty ? "Name can't be empty" : null;
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Invalid Email';
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    return value.length < 6 ? 'Min 6 char required' : null;
  }

  String _validateConfirmPassword(String value) {
    return value.length < 5 ? 'Min 5 char required' : null;
  }

  void _onTappedButtonRegister() async{
  //  if(!_keyValidationForm.currentState.validate())return;
    if(otpSent!=_textControllerotp.text)
      {
        getCustomDialog(context, "Unable to register","OTP entered is invalid",DialogType.ERROR);
        return;
      }
    setState(() {
      isLoading=true;
    });
    await Provider.of<ProviderLogin>(context,listen:false).signupAPI(_textEditConEmail.text,
        _textControllerphone.text,
        _textEditConName.text,
        _textControllerotp.text,
        _textEditConPassword.text,
        context);

    setState(() {
      isLoading=false;
    });
  }

  void _onTappedTextlogin() {}

  String _validateOtp(String value) {
    return value.trim().isEmpty ? "OTP can't be empty" : null;
  }

  String _validatePhone(String value) {
    return value.trim().isEmpty||value.trim().length!=10 ? "Please enter 10 digit phone number" : null;
  }



  void sendOtp(String value)async {

    var rnd = new math.Random();
    //otpSent = rnd.nextInt(10000).toString();
    otpSent = "1234";
    String otpMsg="Your one time OTP to login to Big Midas Is $otpSent";
    print(otpSent);
   // if(true)return;
    var request = http.Request('GET', Uri.parse('http://sms.smsinsta.in/vb/apikey.php?apikey=36116418143121313336&senderid=SMSINS&route=3&number=$value&message=$otpMsg'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(otpSent);
      getCustomDialog(context, "Otp Sent","Otp sent to Phone number $value",DialogType.INFO);
    }
    else {
      print(response.reasonPhrase);
      getCustomDialog(context, "Otp Sent","Otp sent to Phone number $value",DialogType.INFO);
    }

  }
}
