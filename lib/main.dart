import 'package:fidibo_test/gameplay_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const GameScreen());
}

class GameScreen extends GetView<GamePlayController> {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: GetBuilder<GamePlayController>(
                    init: GamePlayController(
                        ScreenUtil().screenWidth - 60,
                        ScreenUtil().screenHeight -
                            ScreenUtil().statusBarHeight -
                            60),
                    builder: (controller) {
                      return SafeArea(
                        child: Stack(
                          children: [
                            Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GetBuilder<GamePlayController>(
                                    init: controller,
                                    tag: "rock",
                                    builder: (controller) {
                                      return Text(
                                        "Rock!",
                                        style: TextStyle(
                                            fontSize: 50,
                                            fontStyle: FontStyle.italic,
                                            color: controller.rockTextColor),
                                      );
                                    }),
                                GetBuilder<GamePlayController>(
                                    init: controller,
                                    tag: "paper",
                                    builder: (controller) {
                                      return Text(
                                        "Paper!",
                                        style: TextStyle(
                                            fontSize: 50,
                                            fontStyle: FontStyle.italic,
                                            color: controller.paperTextColor),
                                      );
                                    }),
                                GetBuilder<GamePlayController>(
                                    init: controller,
                                    tag: "scissor",
                                    builder: (controller) {
                                      return Text(
                                        "scissor!",
                                        style: TextStyle(
                                            fontSize: 50,
                                            fontStyle: FontStyle.italic,
                                            color: controller.scissorTextColor),
                                      );
                                    })
                              ],
                            )),
                            Stack(
                              children: [
                                for (final obj in controller.objects)
                                  Positioned(
                                    left: obj.x + .5,
                                    top: obj.y + .5,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: obj.color,
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Center(
                                          child: Text(obj.type
                                              .toString()
                                              .split('.')
                                              .last)),
                                    ),
                                  ),
                              ],
                            ),
                            Positioned(
                                bottom: 5,
                                left: 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("🪨 : ${controller.rocksWin}")
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text("📄 : ${controller.papersWin}")
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text("✂️ : ${controller.scissorsWin}")
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      );
                    }),
              ),
            ));
  }
}
