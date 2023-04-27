import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/* camera button */

class Voice2Screen extends StatefulWidget {
  const Voice2Screen({super.key});

  // 상태 관리
  @override
  _VoiceScreen2State createState() => _VoiceScreen2State();
}


class _VoiceScreen2State extends State<Voice2Screen>{
  FlutterTts ftts = FlutterTts();
  late File _image;
  final picker = ImagePicker();
  
  get path => null;

  @override 
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: "안녕하세요");

    Future getImage(ImageSource imageSource) async{
      final pickedFile = await picker.getImage(source: imageSource);

      setState(() {
        _image = File(pickedFile!.path);
      });

      final appDir = await path.provider.getApplicationDocumentsDirectory();
      // final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile!.path);
      final savedFile = await _image.copy('${appDir.path}/$fileName');
      String picPath = savedFile.path;
    }


    return Positioned(
      child: Container(
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/voice1.png'),
              Positioned(
                top: 440,
                left: 45,
                child: SizedBox(
                  width: 120,
                  height: 120,
                    child: TextButton(
                      child: const Text(" "),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      }
                    ),
                  ),
              ),

              Positioned(
                top: 440,
                left: 200,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: TextButton(
                    child: const Text(" "),
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
                  // child: const Icon(
                  //     Icons.camera,
                  //     size: 18,
                  //   ),
                  // ),
                ),
              ),
              ),
            ],
        ),
      ),
    );
  }

      
        
}