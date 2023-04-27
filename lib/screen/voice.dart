import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bim_flutter/widget/voice1.dart';

import '../widget/voice2.dart';
import '../widget/voiceText.dart';



class VoiceScreen extends StatefulWidget {
  // 상태 관리
  @override
  _VoiceScreen1State createState() => _VoiceScreen1State();
}


class _VoiceScreen1State extends State<VoiceScreen> with TickerProviderStateMixin{
  late File _image;
  final picker = ImagePicker();

  // final FlutterTts tts = FlutterTts();
  // final TextEditingController controller = TextEditingController(text: "hi");
  // late TabController controller;

  late TabController tabController;
  int _tabIndex = 0;
  
  @override
  void initState() {
    // tabController = TabController(vsync: this, length: 3);
    tabController = TabController(vsync: this, length: 3)
      ..addListener(() {
        setState(() => _tabIndex = tabController.index);
      });

    super.initState();
  }

  static const colors = [
  Color.fromARGB(255, 255, 243, 181),
  Color.fromARGB(255, 181, 215, 255),
  ];

  @override
  Widget build(BuildContext context){
    

    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[ Container(
          height: 80,
          color: Colors.white,
          child: TabBar(
              labelStyle: const TextStyle(fontSize: 17,fontFamily: 'SF Pro Text', fontWeight: FontWeight.bold,),  //For Selected tab
              unselectedLabelStyle: const TextStyle(fontSize: 17,fontFamily: 'SF Pro Text', fontWeight: FontWeight.bold,), //For Un-selected Tabs
              controller: tabController,  // 컨트롤러 연결
              indicator: BoxDecoration(
              color: colors[_tabIndex],
            ),
              tabs: const [
                  Tab(text: '\n점자 ▷ 묵자'),
                  Tab(text: '\n묵자 ▷ 묵자'),
              ],
          ),
        ),
        Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Container(
                  //screen 넣기
                  color: const Color.fromARGB(255, 255, 243, 181),
                  child: Voice1Screen(),
                ),
                
                Container(
                  color: const Color.fromARGB(255, 181, 215, 255),
                  child: Voice2Screen(),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  }
}
