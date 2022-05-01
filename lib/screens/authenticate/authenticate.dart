import 'package:flutter/material.dart';

import 'package:wol_pro_1/volunteer/authenticate/register_volunteer.dart';
import 'package:wol_pro_1/volunteer/authenticate/register_volunteer_1.dart';

import 'package:wol_pro_1/volunteer/authenticate/sign_in_volunteer.dart';

import '../../Refugee/authenticate/register_refugee.dart';
import '../../Refugee/authenticate/sign_in_refugee.dart';
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
        return RegisterVol1(toggleView:  toggleView);
      }
    return OptionChoose();
    }
  }
}