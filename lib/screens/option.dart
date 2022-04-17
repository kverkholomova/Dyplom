import 'package:flutter/cupertino.dart';
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
      
      body: Container(
        color: Color.fromRGBO(234, 191, 213, 0.8),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 250,horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: MaterialButton(
                  color: Color.fromRGBO(137, 102, 120, 0.8),
                  child: Text('Volunteer'),
                  onPressed: () {
                    option_refugee=false;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
                  },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: MaterialButton(
                      color: Color.fromRGBO(137, 102, 120, 0.8),
                      child: Text('Refugee'),
                      onPressed: () {
                        option_refugee=true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
