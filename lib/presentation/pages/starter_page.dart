import 'package:flutter/material.dart';
import 'package:gemini_app/core/constants/welcoming.dart';
import 'package:gemini_app/presentation/controllers/starter_controller.dart';
import 'package:gemini_app/presentation/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  StarterController starterController = Get.find<StarterController>();

  @override
  void initState() {
    super.initState();
    starterController.speak(WELCOMING_MESSAGE);
    starterController.initVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    starterController.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StarterController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset("assets/animations/gemini_logo.json"),
            ),
            Expanded(
              child: starterController.controller.value.isInitialized
                  ? VideoPlayer(starterController.controller)
                  : Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white, width: 2)),
                  child: MaterialButton(
                      onPressed: () {
                        Get.off(() => const HomePage());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Chat with gemini'.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      )),
                ),
              ],
            )
          ]),
        ),
      );
    });
  }
}
