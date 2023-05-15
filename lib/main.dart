import 'package:bim_flutter/screen/open_screen.dart';
import 'package:bim_flutter/screen/voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bim_flutter/widget/VoiceWidget.dart';
import 'package:bim_flutter/screen/tuto_screen.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:bim_flutter/widget/voiceText.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIM',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink[200], colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
      // home: const TutoFirstScreen(),
      home: OpenScreen(),
    );
  }
}


// void _reloadApp(BuildContext context) {
//   runApp(MyApp());
// }