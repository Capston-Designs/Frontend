import 'dart:io';
import 'package:bim_flutter/widget/voiceText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';

class VoiceWidget extends StatefulWidget {
  const VoiceWidget({super.key});

  // VoiceWidget(VoiceText voiceText);

  // 상태 관리
  @override
  _VoiceScreenState createState() => _VoiceScreenState();

  applyTo(ClampingScrollPhysics clampingScrollPhysics) {}
}

class _VoiceScreenState extends State<VoiceWidget> {
  late File _image;
  final picker = ImagePicker();

  final FlutterTts tts = FlutterTts();
  final TextEditingController controller = TextEditingController(text: "hi");
  // final TextEditingController controller = TextEditingController();
  
  
  // @override
  // void initState(){
  //   super.initState();
  //   tts.setLanguage("en-US");
  //   tts.setSpeechRate(0.4);
  // }

  // _VoiceScreenState(){
  //   tts.setLanguage('en');
  //   tts.setSpeechRate(0.4);
  // }

  @override
  Widget build(BuildContext context){
    Future getImage(ImageSource imageSource) async{
      final pickedFile = await picker.getImage(source: imageSource);

      setState(() {
        _image = File(pickedFile!.path);
      });
    }
    
    return Container(
      width: 360,
      height: 800,
      decoration: BoxDecoration(
          borderRadius : const BorderRadius.only(
            topLeft: Radius.circular(37),
            topRight: Radius.circular(37),
            bottomLeft: Radius.circular(37),
            bottomRight: Radius.circular(37),
          ),
      color : const Color.fromRGBO(0, 0, 0, 1),
      border : Border.all(
          color: const Color.fromRGBO(0, 0, 0, 1),
          width: 0,
        ),
    ),
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: Container(
        width: 600,
        height: 1000,
        decoration: const BoxDecoration(
          color : Color.fromRGBO(243, 243, 243, 1),
      ),
      ),
      ),

      
      // 흰색 네모 (출력화면)
      Positioned(
        top: 154,
        left: 0,
        child: SizedBox(
      width: 391,
      height: 423,
      
      child: Stack(
        children: <Widget>[
          // voiceText 위젯 추가 !!
          // VoiceText(),
          // TextField(
          //   controller: controller,
          // ),
          Positioned(
        top: 0,
        left: 0,
        child: Container(
        width: 391.5,
        height: 423,
        decoration: BoxDecoration(
          boxShadow : const [BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.07000000029802322),
          offset: Offset(3,4),
          blurRadius: 9
      )],
      color : const Color.fromRGBO(255, 255, 255, 1),
      border : Border.all(
          color: const Color.fromRGBO(0, 0, 0, 1),
          width: 1,
        ),
  )
      )
      ),
        ]
      )
    )
      ),

      // 점자 묵자 위치 (위아래)
      Positioned(
        top: 86,
        left: 63,
        child: Container(
      width: 241,
      height: 54,
      decoration: const BoxDecoration(),
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: SizedBox(
      width: 241,
      height: 54,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: Container(),
        // child: null,
      ),
      // 점자 묵자 출력화면
      // const Positioned(
      //   top: 6,
      //   left: 35,
      //   child: Text('점자 →묵자   출력화면', textAlign: TextAlign.center, style: TextStyle(
      //   color: Color.fromRGBO(0, 0, 0, 1),
      //   fontFamily: 'Noto Sans KR',
      //   fontSize: 18,
      //   letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
      //   fontWeight: FontWeight.normal,
      //   height: 1
      // ),)
      // ),
        ]
      )
    )
      ),
        ]
      )
    )
      ),
      // 점자 묵자 출력화면 !!
      Positioned(
        top: 60,
        left: 80,
        child: Container(
      decoration: BoxDecoration(
          borderRadius : const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
      boxShadow : const [BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
          offset: Offset(0,4),
          blurRadius: 4
      )],
      color : const Color.fromRGBO(255, 255, 255, 1),
      border : Border.all(
          color: const Color.fromRGBO(0, 0, 0, 1),
          width: 0.800000011920929,
        ),
  ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        
        children: const <Widget>[
          Text('점자 →묵자   출력화면', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'SF Pro Text',
        fontSize: 17.5,
        letterSpacing: -0.4300000071525574,
        fontWeight: FontWeight.normal,
        height: 1.2941176470588236
      ),),

        ],
      ),
    )
      ),

      // 글씨 출력
      Positioned(
        top: 165,
        left: 15,
        child: Column(
          children: const <Widget>[
            Text('안녕하세요', style: TextStyle(color: Colors.black87, fontSize: 20,
              fontFamily: 'SF Pro Text',
              letterSpacing: -0.4300000071525574,
              fontWeight: FontWeight.normal,)),
            // TextField(
            //   controller: controller,
            // ),
          ],
        )
      ),


      // voice
      Positioned(
        top: 645,
        left: 250,
        child: SizedBox(
      width: 100,
      height: 100,
      // decoration: const BoxDecoration(),

      child: Stack(
        children: <Widget>[
          Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            width: 100,
            height: 100,
        
            child: Stack(
              children: const <Widget>[
              //       TextField(
              //   controller: controller,
              // ),
                    VoiceText(),
                  ],
                ),
              ),
          ),
        ],
      ),
    ),
      ),



      // camera 
      Positioned(
        top: 620,
        left: 69,
        child: Container(
          width: 75.69206237792969,
          height: 68.12285614013672,
          decoration: const BoxDecoration(),

          child: Stack(
            children: <Widget>[
              FloatingActionButton(
                // top: 0,
                // left: 0,
                child: const Icon(
                  Icons.add_a_photo,
                  size: 18,
                  ),
                onPressed: () { 
                  getImage(ImageSource.camera);
                },
      ),
        ],
      ),
    ),
      ),Positioned(
        top: 620,
        left: 217,
        child: Container(
      width: 81.29320526123047,
      height: 68.17574310302734,
      decoration: const BoxDecoration(
          
  ),
      child: Stack(
        children: const <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: SizedBox(
      width: 81.29320526123047,
      height: 68.17574310302734,
      
      
    )
      ),
        ]
      )
    )
      ),


      // 소리
      


      // 카메라..
    //   Positioned(
    //     top: 86,
    //     left: 312,
    //     child: SizedBox(
    //   width: 37.27543640136719,
    //   height: 100,
      
    //   child: Stack(
    //     children: <Widget>[
    //       Positioned(
    //       top: 37,
    //       left: 37.275367736816406,
    //       child: Transform.rotate(
    //       angle: -180 * (math.pi / 180),
    //       child: SvgPicture.asset(
    //       'assets/images/vector.svg',
    //       semanticsLabel: 'vector'
    //       ),
    //     ),
    //   ),
      
    //     ]
    //   ),
      
    // ),
    //   ),
      
        ]
      )
    );
    

  }
}
