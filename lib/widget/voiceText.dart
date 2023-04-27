import 'dart:async';

import 'package:bim_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';
import 'package:bim_flutter/widget/VoiceWidget.dart';

class VoiceText extends StatefulWidget{
  const VoiceText({super.key});

  @override
  _VoiceTextState createState() => _VoiceTextState();
}

class _VoiceTextState extends State<VoiceText>{
  FlutterTts ftts = FlutterTts();

  @override
  Widget build(BuildContext context) {

  final TextEditingController controller = TextEditingController(text: "안녕하세요");

    return Scaffold(
      body: Container(
        
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/voice2.png'),
              Positioned(
                top: 880,
                left: 60,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: TextButton(
                    onPressed: () async {
                      
                      await ftts.setLanguage("ko-KR"); //en-US ko-KR
                      await ftts.setSpeechRate(0.5); //speed of speech
                      await ftts.setVolume(5.0); //volume of speech
                      await ftts.setPitch(1); //pitc of sound

                      //play text to sp
                      // var result = await ftts.speak("Hello World, this is Flutter Campus.");
                      var result = await ftts.speak(controller.text);
                      if(result == 1){
                          //speaking
                      }else{
                          //not speaking
                      }
                  }, 
                  // 버튼
                  // child: Text("Text to Speech"),
                  child: const Icon(
                      Icons.camera,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}

// class _VoiceTextState extends State<VoiceText> {

  
  
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
  
  
// }

