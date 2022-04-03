import 'package:flutter/material.dart';
import 'package:wol_pro_1/screens/authenticate/register_refugee.dart';
import 'package:wol_pro_1/screens/authenticate/register_volunteer.dart';
import 'package:wol_pro_1/screens/authenticate/sign_in_refugee.dart';
import 'package:wol_pro_1/screens/authenticate/sign_in_volunteer.dart';

import '../option.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {


  bool showSignInRef = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignInRef = !showSignInRef);
  }


  @override
  Widget build(BuildContext context) {
    if (showSignInRef) {
      if(option_refugee){
        return SignInRef(toggleView:  toggleView);
      }
      else if(!option_refugee){
        return SignInVol(toggleView:  toggleView);
      }

      return OptionChoose();
    }

    else {
      if(option_refugee){
        return RegisterRef(toggleView:  toggleView);
      }
      else if(!option_refugee){
        return RegisterVol(toggleView:  toggleView);
      }
    return OptionChoose();
    }
  }
}