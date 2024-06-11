import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/controllers/home_controller.dart';
import 'package:gemini_app/presentation/widgets/item_gemini_message.dart';
import 'package:gemini_app/presentation/widgets/item_user_message.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.getMessages();
    controller.initSpeech();
    controller.initTts();
    controller.initShake(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Container(
            width: 130,
            child: Lottie.asset("assets/animations/gemini_logo.json"),
          ),
        ),
        body: Container(
          //margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        var message = controller.messages[index];
                        return message.isMine!
                            ? itemOfUserMessage(message)
                            : itemOfGeminiMessage(message, controller, context);
                      },
                    ),
                    controller.isLoading
                        ? Center(
                            child: SizedBox(
                              height: 70,
                              child: Lottie.asset(
                                  'assets/animations/gemini_buffering.json'),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 2, color: Colors.grey.shade600)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.image != null
                        ? Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 16, bottom: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    base64Decode(
                                      controller.image!,
                                    ),
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                padding:
                                    const EdgeInsets.only(right: 10, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        child: const Icon(
                                            CupertinoIcons.xmark_circle_fill))
                                  ],
                                ),
                              )
                            ],
                          )
                        : SizedBox(),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.textController,
                            onSubmitted: (text) {
                              var text = controller.textController.text
                                  .toString()
                                  .trim();
                              controller.onSendPressed(text);
                            },
                            maxLines: null,
                            textInputAction: TextInputAction.send,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Message",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade600)),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.attach_file,
                                  color: Colors.grey.shade600),
                              onPressed: () {
                                controller.onSelectImage();
                              },
                            ),
                            IconButton(
                              color: controller.microphoneColor,
                              icon: const Icon(
                                Icons.mic,
                              ),
                              onPressed: () {
                                controller.onStartListening();
                              },
                            ),
                            IconButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: -10),
                              icon: Icon(
                                Icons.send,
                                color: Colors.grey.shade600,
                              ),
                              onPressed: () {
                                var text = controller.textController.text
                                    .toString()
                                    .trim();
                                controller.onSendPressed(text);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
