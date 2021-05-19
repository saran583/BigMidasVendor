import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/screens/register.dart';
import 'package:bigmidasvendor/screens/selectservice.dart';
import 'package:bigmidasvendor/widgets/appspecificsignaturewidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static String routeName="/login";
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  static var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _textControllerPhone = TextEditingController();

  TextEditingController _textControllerPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLogginIn=false;

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //backgroundColor: AppColors.colorGrey,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 32.0),
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
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          child: Image.asset("assets/images/logo_Big_Midas.jpeg",height: 180,width: 180,),
        )
    );
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
                    'Login',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black),
                  ),
                ), // title: login
                Container(
                  child: TextFormField(
                    controller: _textControllerPhone,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: _validateUserName,
                    onFieldSubmitted: (String value) {
                    //  FocusScope.of(context).requestFocus(_passwordEmail);
                    },
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        //prefixIcon: Icon(Icons.email),
                        icon: Icon(Icons.phone)),
                    onChanged: (value){

                    },

                  ),
                ), //text
                Container(
                  child: TextFormField(
                      controller: _textControllerPassword,
                    //  focusNode: _passwordConfirmFocus,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: _validateConfirmPassword,
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
//                Container(
//                  margin: EdgeInsets.only(top: 32.0),
//                  width: double.infinity,
//                  child: RaisedButton(
//                    color: Colors.red,
//                    textColor: Colors.white,
//                    elevation: 5.0,
//                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
//                    child: Text(
//                      'Login',
//                      style: TextStyle(fontSize: 16.0),
//                    ),
//                    onPressed: () {
//                      //if (_keyValidationForm.currentState.validate()) {
//                      //  _onTappedButtonRegister();
//                        Navigator.pushNamed(context, SelectService.routeName);
//                      //}
//                    },
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(25.0)),
//                  ),
//                ), //button: login
              isLogginIn?Container(child: CircularProgressIndicator(),margin: EdgeInsets.only(top: 10),):  getAwesomeButton("Login",()async{

                if(!_keyValidationForm.currentState.validate())return
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isLogginIn=true;
                  });


                await   Provider.of<ProviderLogin>(context,listen:false).loginAPI("",
                    _textControllerPhone.text,
                    _textControllerPassword.text,context);
                  //Navigator.pushNamed(context, SelectService.routeName);

                print("Api call successfull");
                  setState(() {
                    isLogginIn=false;
                  });
                }),
                Container(
                    margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Not a user? ',
                        ),
                        InkWell(
                          splashColor: Colors.red,
                          onTap: () {
                            //_onTappedTextlogin();
                            Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                          },
                          child: Text(
                            ' Sign Up',
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
    return value.trim().isEmpty ? "Phone number can not be empty" : null;
  }

  String _validateEmail(String value) {
    return value.trim().isEmpty ? "Password can not be empty" : null;
  }

  String _validatePassword(String value) {
    return value.length < 5 ? 'Min 5 char required' : null;
  }

  String _validateConfirmPassword(String value) {
    return value.length < 4 ? 'Min 4 char required' : null;
  }

  void _onTappedButtonRegister() {}

  void _onTappedTextlogin() {}
}