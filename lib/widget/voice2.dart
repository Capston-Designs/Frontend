import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';

/* 묵자 */

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
  String text1 = '';
  
  @override
  void dispose() {
    text1 = ''; // text1 초기화
    super.dispose();
  }

  // 사진 가져오기 image picker
  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> uploadImageToServer() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera); // .camera로 변경 가능

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageFile.path),
      });

      try {
        Dio dio = new Dio();
        dio.options.headers['Content-Type'] = 'application/json';
        Response response = await dio.post(
          'https://e1e3-210-123-132-243.ngrok-free.app/api/korean/',
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
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/voice1.png'),
          Positioned(
            top: 440,
            left: 45,
            child: SizedBox(
              width: 120,
              height: 120,
              child: TextButton(
                // camera button
                child: const Text(" "),
                onPressed: () async {
                  uploadImageToServer();
                },
              ),
            ),
          ),
            // text field
            Positioned(
              top: 20,
              left: 20,
              child: SizedBox(
                width: 330,
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
      );
  }
}
