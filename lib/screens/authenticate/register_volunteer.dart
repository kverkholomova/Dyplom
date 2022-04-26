import 'package:flutter/material.dart';
import 'package:wol_pro_1/shared/constants.dart';

import '../../services/auth.dart';
import '../../shared/loading.dart';
import '../option.dart';

class RegisterVol extends StatefulWidget {

  final Function toggleView;
  RegisterVol({ required this.toggleView });

  @override
  _RegisterVolState createState() => _RegisterVolState();
}

class _RegisterVolState extends State<RegisterVol> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OptionChoose()),
        );
        return true;
      },
      child: loading ? Loading() :Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
          elevation: 0.0,
          title: Text('Sign up',style: TextStyle(fontSize: 16),),
          leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OptionChoose()),
            );
          },),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person,color: Colors.white,),
              label: Text('Sign In',style: TextStyle(color: Colors.white),),
              onPressed: () => widget.toggleView(),
            ),
          ],
        ),
        body: Container(
          color: Color.fromRGBO(234, 191, 213, 0.8),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: SizedBox(
                    height: 55,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 55,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 240),
                  child: Container(
                    height: 55,
                    width: 275,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: MaterialButton(
                        color: Color.fromRGBO(94, 167, 187, 0.8),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState!.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPasswordVol(email, password);
                            if(result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                          }
                        }
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}