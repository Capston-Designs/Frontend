import 'package:bim_flutter/screen/voice.dart';
import 'package:flutter/material.dart';
import '../widget/VoiceWidget.dart';


class TutoFirstScreen extends StatelessWidget {
  const TutoFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          Positioned(
            child: Container(
              decoration: const BoxDecoration(image: 
                DecorationImage(image: 
                  AssetImage('assets/images/tuto0.png'),
                ),
              ),
              alignment: const Alignment(0.9, 0.97),
                child: TextButton(
                  child: 
                    const Text('         다음         ', 
                      style: TextStyle(
                        fontFamily: 'SF Pro Text', 
                        fontSize: 25, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TutoSecondScreen()),
                    );
                  },
                ),
              )
            )
        ],)
        
      ),
    );
  }
}

class TutoSecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          Positioned(
            child: Container(
              decoration: const BoxDecoration(image: 
                DecorationImage(image: 
                  AssetImage('assets/images/tuto1.png'),
                ),
              ),
              alignment: const Alignment(0.9, 0.97),
                child: TextButton(
                  child: 
                    const Text('         다음         ', 
                      style: TextStyle(
                        fontFamily: 'SF Pro Text', 
                        fontSize: 25, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TutoThirdScreen()),
                    );
                  },
                ),
              )
            )
        ],)
        
      ),
    );
  }
}

class TutoThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          Positioned(
            child: Container(
              decoration: const BoxDecoration(image: 
                DecorationImage(image: 
                  AssetImage('assets/images/tuto2.png'),
                ),
              ),
              alignment: const Alignment(0.9, 0.97),
                child: TextButton(
                  child: 
                    const Text('         다음         ', 
                      style: TextStyle(
                        fontFamily: 'SF Pro Text', 
                        fontSize: 25, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TutolastScreen()),
                    );
                  },
                ),
              )
            )
        ],)
        
      ),
    );
  }
}

class TutolastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned(
          child: VoiceScreen(),
          ),
        ],
      ),
    );
  }
}