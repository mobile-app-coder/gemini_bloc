import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StarterController extends GetxController {
  late VideoPlayerController controller;

  initVideoPlayer() async
  {
    controller = VideoPlayerController.asset("assets/videos/gemini.mp4")
      ..initialize().then((_) {
        update();
      });
    controller.play();

    controller.setLooping(true);

  }

  onDispose() {
    controller.dispose();
  }




  //tts
  FlutterTts flutterTts = FlutterTts();

  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.7;
  bool isCurrentLanguageInstalled = false;



  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isIOS => !kIsWeb && Platform.isIOS;

  speak(String? text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.speak(text);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
