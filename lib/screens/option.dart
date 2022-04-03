import 'package:flutter/material.dart';
import 'package:wol_pro_1/screens/authenticate/authenticate.dart';
import 'package:wol_pro_1/screens/wrapper.dart';
import '../shared/loading.dart';

var option_refugee=true;

class OptionChoose extends StatefulWidget {
  const OptionChoose({Key? key}) : super(key: key);


  @override
  State<OptionChoose> createState() => _OptionChooseState();
}

class _OptionChooseState extends State<OptionChoose> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
              child: RaisedButton(
              color: Colors.blue,
              child: Text('Volunteer'),
              onPressed: () {
                option_refugee=false;
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Wrapper()));
              },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
              child: RaisedButton(
                color: Colors.blue,
                child: Text('Refugee'),
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Wrapper()));
                },
              ),
            ),
          ),
        ],
      ),

    );
  }
}
