import 'package:fidibo_test/gameplay_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GameScreen());
}

class GameScreen extends GetView<GamePlayController> {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GetBuilder<GamePlayController>(
            init: GamePlayController(),
            builder: (controller) {
              return Stack(
                children: [
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Rock!",
                        style: TextStyle(
                          fontSize: 50,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        "Paper!",
                        style: TextStyle(
                            fontSize: 50, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Scissor!",
                        style: TextStyle(
                            fontSize: 50, fontStyle: FontStyle.italic),
                      )
                    ],
                  )),
                  Stack(
                    children: [
                      for (final obj in controller.objects)
                        Positioned(
                          left: obj.x,
                          top: obj.y,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: obj.color,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                                child:
                                    Text(obj.type.toString().split('.').last)),
                          ),
                        ),
                    ],
                  ),
                  Positioned(
                      bottom: 5,
                      left: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [Text("🪨 : ${controller.rocksWin}")],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [Text("📄 : ${controller.papersWin}")],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [Text("✂️ : ${controller.scissorWin}")],
                          )
                        ],
                      ))
                ],
              );
            }),
      ),
    );
  }
}
