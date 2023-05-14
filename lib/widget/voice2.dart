import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:bot_toast/bot_toast.dart';

/* 묵자 */

class Voice2Screen extends StatefulWidget {
  const Voice2Screen({super.key});

  // 상태 관리
  @override
  _VoiceScreen2State createState() => _VoiceScreen2State();
}

String text1 = ' ';

class _VoiceScreen2State extends State<Voice2Screen>{
  FlutterTts ftts = FlutterTts();
  late File _image;
  final picker = ImagePicker();


  @override 
  Positioned build(BuildContext context)  {
    final TextEditingController controller = TextEditingController(text: text1);
    

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
              'assets/images/voice1.png'),
              Positioned(
                top: 440,
                left: 45,
                child: SizedBox(
                  width: 120,
                  height: 120,
                    child: TextButton(
                      child: const Text(" "),
                      onPressed: () async {
                        // getImage(ImageSource.camera);
                        uploadImageToServer();
                        
                        // text1 = await getTextFromServer();
                        // print('text : '+text1);
                      }
                    ),
                  ),
              ),
              // 슬라이드 추가하기
              Positioned(
                top: 20,
                left: 20,
                child: SizedBox(
                  width: 350,
                  height: 400,
                  child: Text(''+text1,
                  style: const TextStyle(
                        fontFamily: 'SF Pro Text', 
                        fontSize: 20, 
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
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
                ),
              ),
              ),
            ],
        ),
      ),
    );
  }
}


// split func
// Future<String> splitText(String texts) async {
//   String textr = texts.substring(10,texts.indexOf(","));
//   textr = textr.substring(0,textr.length-1);
//   text1 = textr;
//   return text1;
// }

// post
Future<void> uploadImageToServer() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

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
          'https://2d7a-220-122-54-34.ngrok-free.app/api/korean/',
          data: formData
      );
      text1 = response.toString();

      // text 자르기
      String textr = text1.substring(9,text1.indexOf("h"));
      textr = textr.substring(0,textr.length-1);
      text1 = textr;

      print(response);
    } catch (e) {
      print(e);
    }
    // text1 = await getTextFromServer();

    // String textr = text1.substring(9,text1.indexOf('h'));
    // text1 = textr;
    // String textf = splitText(text1) as String;

    // splitText(text1);
    // print('text : '+text1);
  }
}


// get
// Future<String> getTextFromServer() async {
//   try {
//     Dio dio = new Dio();
//     Response response = await dio.get('https://a2c9-14-45-91-84.ngrok-free.app/Korean/translate');
//   //  var jsonbody = json.decode(response.data);
//   //  return jsonbody['answer'];
//   return response.data.toString();
//   } catch (e) {
//     print(e);
//     return 'error';
//   }
// }
