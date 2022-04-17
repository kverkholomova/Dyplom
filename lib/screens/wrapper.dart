import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wol_pro_1/screens/authenticate/authenticate.dart';

import 'package:wol_pro_1/screens/home/home_ref.dart';
import 'package:wol_pro_1/screens/home/home_vol.dart';
import 'package:wol_pro_1/screens/option.dart';
import 'package:wol_pro_1/screens/settings/register_form.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user=Provider.of<Users?>(context);
    if (user==null){
      return Authenticate();
    } else if(option_refugee){
      return HomeRef();
    }else if(!option_refugee){
      return VolunteerRegisterForm();
    }
    else{
      return OptionChoose();
    }
    //return either Home or Return Widget

  }
}
