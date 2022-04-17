import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:wol_pro_1/shared/application.dart';

import '../home/home_vol.dart';

class SetVol extends StatefulWidget {
  const SetVol({Key? key}) : super(key: key);

  @override
  State<SetVol> createState() => _SetVolState();
}

class _SetVolState extends State<SetVol> {


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
      body: Column(
        children: [
          AnimatedButton(
            height: 70,
            width: 200,
            text: 'Transfer',
            isReverse: true,
            selectedTextColor: Colors.black,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            backgroundColor: Colors.black,
            borderColor: Colors.white,
            borderRadius: 50,
            borderWidth: 2, onPress: () {
              chosen_category='Transfer';
              //volunteer_preferencies.add('Transfer');
          },
          ),
          AnimatedButton(
            height: 70,
            width: 200,
            text: 'Accomodation',
            isReverse: true,
            selectedTextColor: Colors.black,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            backgroundColor: Colors.black,
            borderColor: Colors.white,
            borderRadius: 50,
            borderWidth: 2, onPress: () {
            chosen_category='Accomodation';
            //volunteer_preferencies.add('Accomodation');
          },
          ),
          AnimatedButton(
            height: 70,
            width: 200,
            text: 'Assistance with animals',
            isReverse: true,
            selectedTextColor: Colors.black,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            backgroundColor: Colors.black,
            borderColor: Colors.white,
            borderRadius: 50,
            borderWidth: 2, onPress: () {
            chosen_category='Assistance with animals';
            //volunteer_preferencies.add('Assistance with animals');
          },
          ),
        ],
      ),
    );
  }
}
