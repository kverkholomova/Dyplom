import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:wol_pro_1/screens/home/applications_vol.dart';

import '../../shared/application.dart';
import '../home/home_vol.dart';

class VolunteerRegisterForm extends StatefulWidget {
  const VolunteerRegisterForm({Key? key}) : super(key: key);

  @override
  State<VolunteerRegisterForm> createState() => _VolunteerRegisterFormState();
}

class _VolunteerRegisterFormState extends State<VolunteerRegisterForm> {
  bool vol_value=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),

          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeVol()));

          },
        ),
      ),
      body: Container(
        color: Color.fromRGBO(234, 191, 213, 0.8),
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: AnimatedButton(
                    selectedBackgroundColor: Color.fromRGBO(69, 148, 179, 0.8),
                    height: 40,
                    width: 120,
                    text: 'Transfer',

                    textStyle: TextStyle(color: Colors.black,fontSize: 18),
                    isReverse: true,
                    selectedTextColor: Colors.white,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    backgroundColor: Color.fromRGBO(166, 201, 215, 0.8),
                    borderColor: Colors.white,
                    borderRadius: 50,
                    borderWidth: 1,

                    onPress: () {
                    if(chosen_category==''){
                      chosen_category='Transfer';
                      print(chosen_category);

                    } else if(chosen_category=="Transfer"){
                      chosen_category='';
                      print("Empty: $chosen_category");
                    }

                    //volunteer_preferencies.add('Transfer');
                  },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: AnimatedButton(
                    selectedBackgroundColor: Color.fromRGBO(69, 148, 179, 0.8),
                    height: 40,
                    width: 160,
                    text: 'Accomodation',

                    textStyle: TextStyle(color: Colors.black,fontSize: 18),
                    isReverse: true,
                    selectedTextColor: Colors.white,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    backgroundColor: Color.fromRGBO(166, 201, 215, 0.8),
                    borderColor: Colors.white,
                    borderRadius: 50,
                    borderWidth: 1, onPress: () {
                    if(chosen_category==''){
                      chosen_category='Accomodation';
                      print(chosen_category);

                    } else if(chosen_category=='Accomodation'){
                      chosen_category='';
                      print("Empty: $chosen_category");
                    }

                    //volunteer_preferencies.add('Transfer');
                  },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: AnimatedButton(
                selectedBackgroundColor: Color.fromRGBO(69, 148, 179, 0.8),
                height: 40,
                width: 240,
                text: 'Assistance with animals',

                textStyle: TextStyle(color: Colors.black,fontSize: 18),
                isReverse: true,
                selectedTextColor: Colors.white,
                transitionType: TransitionType.LEFT_TO_RIGHT,
                backgroundColor: Color.fromRGBO(166, 201, 215, 0.8),
                borderColor: Colors.white,
                borderRadius: 50,
                borderWidth: 1, onPress: () {
                if(chosen_category==''){
                  chosen_category='Assistance with animals';
                  print(chosen_category);

                } else if(chosen_category=='Assistance with animals'){
                  chosen_category='';
                  print("Empty: $chosen_category");
                }

                //volunteer_preferencies.add('Transfer');
              },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Container(
                height: 55,
                width: 275,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: MaterialButton(
                    color: Color.fromRGBO(94, 167, 187, 0.8),
                    child: Text(
                      'Finish',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ApplicationsOfVolunteer()));
                    }
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
