import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gemini_app/presentation/controllers/home_controller.dart';
import 'package:gemini_app/presentation/pages/web_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/models/message_model.dart';

Widget itemOfGeminiMessage(MessageModel message, HomeController controller, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.all(16),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 24,
            child: Image.asset('assets/images/gemini_icon.png'),
          ),
          GestureDetector(
            onTap: () {
              controller.speak(message.message);
            },
            child:  Icon(
              Icons.volume_up,
              color: controller.speakerColor ,
            ),
          )
        ]),
        Container(
          alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 16),
            child: Linkify(
              onOpen: (link) {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return WebPage(url: link.url);
                }));
              },
              text: message.message!,
              style: const TextStyle(
                  color: Color.fromRGBO(173, 173, 176, 1), fontSize: 16),
            ),),
      ],
    ),
  );
}
