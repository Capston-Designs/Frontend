import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';

/* 점자 */

class Voice1Screen extends StatefulWidget {
  const Voice1Screen({Key? key}) : super(key: key);

  @override
  _VoiceScreen1State createState() => _VoiceScreen1State();
}

class _VoiceScreen1State extends State<Voice1Screen> {
  FlutterTts ftts = FlutterTts();
  late File _image;
  final picker = ImagePicker();
  String text1 = '';
  

  // 사진 가져오기 image picker
  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      _image = File(pickedFile!.path);
      // _image == "null"
      //   ? getImage(ImageSource.camera)
      //   : upload(_image);
    });
  }

  Future<void> uploadImageToServer() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageFile.path),
      });

      try {
        Dio dio = new Dio();
        dio.options.headers['Content-Type'] = 'application/json';
        Response response = await dio.post(
          'https://2d7a-220-122-54-34.ngrok-free.app/api/braille/',
          data: formData,
        );
        text1 = response.toString();

        // text 자르기
        String textr = text1.substring(9, text1.indexOf("}"));
        textr = textr.substring(0, textr.length - 1);
        text1 = textr;

        print(response);
      } catch (e) {
        print(e);
      }

      setState(() {});
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        child: Stack(
          children: <Widget>[
            Image.asset('assets/images/voice2.png'),
            Positioned(
              top: 440,
              left: 45,
              child: StatefulBuilder(builder: (context, setState) {
                return SizedBox(
                  width: 120,
                  height: 120,
                  child: TextButton(
                    // camera button
                    child: const Text(" "),
                    onPressed: () async {
                      uploadImageToServer();
                    },
                  ),
                );
              }),
            ),

            // text field
            Positioned(
              top: 20,
              left: 20,
              child: SizedBox(
                width: 350,
                height: 400,
                child: Text(
                  '$text1',
                  style: const TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // tts
            Positioned(
              top: 440,
              left: 200,
              child: SizedBox(
                width: 120,
                height: 120,
                child: TextButton(

                    child: const Text(" "),
                    onPressed: () async {
                      final TextEditingController controller = TextEditingController(text: text1);
                      
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
                ),
              ),
              ),
            ],
        ),
      ),
    );
  }
}
