import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';

/* camera button */

class Voice1Screen extends StatefulWidget {
  const Voice1Screen({super.key});

  // 상태 관리
  @override
  _VoiceScreen1State createState() => _VoiceScreen1State();
}


class _VoiceScreen1State extends State<Voice1Screen>{
  FlutterTts ftts = FlutterTts();
  late File _image;
  final picker = ImagePicker();

  @override 
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: "안녕하세요");

    Future getImage(ImageSource imageSource) async{
      final pickedFile = await picker.getImage(source: imageSource);

      setState(() {
        _image = File(pickedFile!.path);
        // _image == "null"
        //   ? getImage(ImageSource.camera)
        //   : upload(_image);
      });
    }


    return Positioned(
      child: Container(
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/voice2.png'),
              Positioned(
                top: 440,
                left: 45,
                child: SizedBox(
                  width: 120,
                  height: 120,
                    child: TextButton(
                      child: const Text(" "),
                      onPressed: () {
                        // getImage(ImageSource.camera);
                        uploadImageToServer();
                        // String getText = getTextFromServer();
                      }
                    ),
                  ),
              ),
              
              // 슬라이드 추가하기
              const Positioned(
                top: 440,
                left: 200,
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Text("d"),
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
                ),
              ),
              ),
            ],
        ),
      ),
    );
  }
}

Future<void> uploadImageToServer() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.camera);
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    // String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imageFile.path),
    });
    try {
      Dio dio = new Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      Response response = await dio.post(
          'https://port-0-backend-5o1j2llh1j01ao.sel4.cloudtype.app/BraiileImg/',
          data: formData
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }
}


// Future<String?> getTextFromServer() async {
//   try {
//     Dio dio = new Dio();
//     Response response = await dio.get('https://0e9c-220-69-155-126.ngrok-free.app/Korean/translate');
//     return response.data.toString();
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }
