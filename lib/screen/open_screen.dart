import 'dart:async';

import 'package:bim_flutter/screen/voice.dart';
import 'package:flutter/material.dart';
import 'package:bim_flutter/screen/tuto_screen.dart';
import 'package:bim_flutter/widget/VoiceWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OpenScreen extends StatefulWidget {
  const OpenScreen({Key? key}) : super(key: key);

  @override
  State<OpenScreen> createState() => _OpenState();
}

class _OpenState extends State<OpenScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      main();
    });
    super.initState();
  }

  @override
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ?? true; //true로 초기화 -> 최초실행임

    // 최초 실행 여부에 따라 화면 전환
    if (isFirstRun) {
      //최초실행
      Navigator.push(context as BuildContext,
          MaterialPageRoute(builder: (context) => const TutoFirstScreen()));
      // 최초 실행이면 isFirstRun 값을 false로 변경
      await prefs.setBool('isFirstRun', false);
    } else {
      //최초실행 아님
      Navigator.push(context as BuildContext,
          MaterialPageRoute(builder: (context) => VoiceScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 360,
            height: 800,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 304,
                  left: 74,
                  child: Container(
                    width: 213,
                    height: 191,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/open.png')
                          //  fit: BoxFit.fitWidth),
                          ),
                    ),
                  ))
            ])));
  }
}