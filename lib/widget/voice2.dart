import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';

/* camera button */

class Voice2Screen extends StatefulWidget {
  const Voice2Screen({super.key});
// hihi
  // 상태 관리
  @override
  _VoiceScreen2State createState() => _VoiceScreen2State();
}


class _VoiceScreen2State extends State<Voice2Screen>{
  FlutterTts ftts = FlutterTts();
  // late File _image;
  final ImagePicker picker = ImagePicker();
  File? _image;
  
  get path => null;

  


  @override 
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: "안녕하세요");

    // Future getImage(ImageSource imageSource) async{
    //   final pickedFile = await picker.getImage(source: imageSource);

    //   setState(() {
    //     _image = File(pickedFile!.path);
    //   });

    //   final appDir = await path.provider.getApplicationDocumentsDirectory();
    //   // final appDir = await getApplicationDocumentsDirectory();
    //   final fileName = path.basename(pickedFile!.path);
    //   final savedFile = await _image.copy('${appDir.path}/$fileName');
    //   String picPath = savedFile.path;
    // }
    final picker = ImagePicker();

    Future getImage(ImageSource source) async {
      final image = await picker.pickImage(source: source);
      // print("실행중");
      if (image == null) return;
      File? img = File(image.path);
      // Uint8List imagebytes = await image.readAsBytes();
      // base64Image = base64.encode(imagebytes);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
        print(_image);
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
                        getImage(ImageSource.camera);
                        
                        _image == "null"
                        ? getImage(ImageSource.camera)
                        : _postRequest(_image);
                        // if(_image != 'null'){
                        //   upload( _image);
                        // }
                        

                      }
                    ),
                  ),
              ),
              Positioned(
                child: SizedBox(
                  child: TextButton(
                    child: const Text("보내기"), 
                    onPressed: (){
                      _image == "null"
                        ? getImage(ImageSource.camera)
                        : _postRequest(_image);
                    },
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

// Future<dynamic> patchUserProfileImage(dynamic input) async {
//     print("프로필 사진을 서버에 업로드 합니다.");
//     var dio = new Dio();
//     try {
//       dio.options.contentType = 'multipart/form-data';
//       dio.options.maxRedirects.isFinite;
//       dio.options.headers['content-Type'] = 'application/json';
//       // dio.options.headers = {'token': token};
//       var response = await dio.patch(
//         'https://port-0-backend-5o1j2llh1j01ao.sel4.cloudtype.app/BraiileImg/',
//         data: input,
//       );
//       print('성공적으로 업로드했습니다');
//       return response.data;
//     } catch (e) {
//       print(e);
//     }
//   }

void upload(dynamic base64Image) async {
    // var uploadcase = {
    //   // 'id' : 3,
    //   "image": base64Image,
    //   "braille" : null
    // };

    Dio dio = new Dio();
    // print("실행중");
    dio.options.headers['Content-Type'] = 'application/json';
    // print(uploadcase);
    try {
      print("posting");
      final Response response = await dio.post( // 서버 링크요
        'https://port-0-backend-5o1j2llh1j01ao.sel4.cloudtype.app/BraiileImg/',
        // data: uploadcase,
        data: {
          // "id" : 3,
          "image": base64Image,
          "braille" : null
        }
      );
      print("post done");
      // print(response.data);
      // print(response.statusCode);
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }

// Future<bool> upload(image) async {
//     Dio dio = new Dio();
//     print("실행중");
//     dio.options.headers['content-Type'] = 'application/json';
//     // print(uploadcase);
//     try {
//       print("posting");
//       final Response response = await dio.post( // 서버 링크요
//         'https://port-0-backend-5o1j2llh1j01ao.sel4.cloudtype.app/BraiileImg/',
//         // data: uploadcase,
//         queryParameters: {
//           // "id" : 3,
//           "image": image,
//           "braille" : null
//         }
//       );
//     print(image);
//     print("done");
//     if (response.statusCode == 200) {
//         final jsonBody = json.decode(response.data); // http와 다른점은 response 값을 data로 받는다. 
//         // jsonBody를 바탕으로 data 핸들링

//         return true;
//       } else { // 200 안뜨면 에러 
//         return false;
//       }
//     } catch (e) {
//       Exception(e);
//     } finally {
//       dio.close();
//     }
//     return false;
//   }
_postRequest(base64Image) async {
    String url = 'https://port-0-backend-5o1jllh1j01ao.sel4.cloudtype.app/BraiileImg/';
    print("post");
    http.Response response = await http.post(
        url as Uri,
        headers: <String, String> {
            'Content-Type': 'application/json',
        },
        body: <String, File> {
            'image': base64Image,
            // "braille" : null
        },
    );
    print("done");
}