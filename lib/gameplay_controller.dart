import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'object_model.dart';

class GamePlayController extends GetxController
    with GetTickerProviderStateMixin {
  List<ObjectModel> objects = <ObjectModel>[];

  int rocksCount = 5;
  int papersCount = 5;
  int scissorCount = 5;
  RxInt rocksWin = 0.obs;
  RxInt papersWin = 0.obs;
  RxInt scissorsWin = 0.obs;
  late Size screenSize;
  Color rockTextColor = Colors.black;

  Color paperTextColor = Colors.black;
  Color scissorTextColor = Colors.black;

  GamePlayController(double w, double h) {
    screenSize = Size(w, h);
  }
  late Ticker ticker;

  @override
  void onInit() {
    super.onInit();
    ticker = createTicker(onTick)..start();
  }

  @override
  void onReady() async {
    super.onReady();
    createObjects();
  }

  @override
  void onClose() {
    ticker.dispose();
    super.onClose();
  }

  Future<void> checkWinner() async {
    if (papersCount == 0 && scissorCount == 0) {
      rockTextColor = Colors.red;
      update(['rock']);
    } else if (rocksCount == 0 && scissorCount == 0) {
      paperTextColor = Colors.green;
      update(['paper']);
    } else if (papersCount == 0 && rocksCount == 0) {
      scissorTextColor = Colors.blue;
      update(['scissor']);
    }
  }

  void onTick(Duration duration) {
    updateObjectsPosition();
    detectCollisions();
    checkWinner();
  }

  void updateObjectsPosition() {
    for (final obj in objects) {
      obj.x += obj.dx;
      obj.y += obj.dy;

      if (obj.x < 0 || obj.x > screenSize.width) obj.dx *= -1;
      if (obj.y < 0 || obj.y > screenSize.height) obj.dy *= -1;
      update();
    }
  }

  void detectCollisions() {
    for (var i = 0; i < objects.length; i++) {
      for (var j = i + 1; j < objects.length; j++) {
        final obj1 = objects[i];
        final obj2 = objects[j];

        final distance =
            sqrt(pow(obj1.x - obj2.x, 2) + pow(obj1.y - obj2.y, 2));
        if (distance <= 60) {
          if (obj1.type == obj2.type) {
            final tempDx = obj1.dx;
            final tempDy = obj1.dy;
            obj1.dx = obj2.dx;
            obj1.dy = obj2.dy;
            obj2.dx = tempDx;
            obj2.dy = tempDy;
          } else {
            final winner = getWinner(obj1, obj2);
            switch (winner.type) {
              case ObjectType.paper:
                papersWin++;
                break;
              case ObjectType.scissor:
                scissorsWin++;
                break;
              case ObjectType.rock:
                rocksWin++;
                break;
              default:
            }
            final loserIndex = objects.indexOf(winner == obj1 ? obj2 : obj1);
            switch (objects.elementAt(loserIndex).type) {
              case ObjectType.rock:
                rocksCount--;
                break;
              case ObjectType.paper:
                papersCount--;

                break;
              case ObjectType.scissor:
                scissorCount--;

                break;
              default:
            }

            objects.removeAt(loserIndex);

            winner.dx *= -1;
            winner.dy *= -1;
          }
        }
      }
    }

    update();
  }

  ObjectModel getWinner(ObjectModel obj1, ObjectModel obj2) {
    if ((obj1.type == ObjectType.rock && obj2.type == ObjectType.scissor) ||
        (obj1.type == ObjectType.paper && obj2.type == ObjectType.rock) ||
        (obj1.type == ObjectType.scissor && obj2.type == ObjectType.paper)) {
      return obj1;
    } else {
      return obj2;
    }
  }

  void createObjects() {
    final List<ObjectModel> rocks = List.generate(rocksCount, (index) {
      final rand = Random().nextDouble();
      final rand2 = Random().nextDouble();

      return ObjectModel.create(
          id: index,
          type: ObjectType.rock,
          color: Colors.red,
          x: rand * screenSize.width,
          y: rand2 * screenSize.height,
          dx: (rand - 0.5) * 10,
          dy: (rand2 - 0.5) * 10);
    });

    final List<ObjectModel> papers = List.generate(papersCount, (index) {
      final rand = Random().nextDouble();
      final rand2 = Random().nextDouble();

      return ObjectModel.create(
          id: index,
          type: ObjectType.paper,
          color: Colors.green,
          x: rand * screenSize.width,
          y: rand2 * screenSize.height,
          dx: (rand - 0.5) * 10,
          dy: (rand2 - 0.5) * 10);
    });
    final List<ObjectModel> scissors = List.generate(scissorCount, (index) {
      final rand = Random().nextDouble();
      final rand2 = Random().nextDouble();

      return ObjectModel.create(
          id: index,
          type: ObjectType.scissor,
          color: Colors.blue,
          x: rand * screenSize.width,
          y: rand2 * screenSize.height,
          dx: (rand - 0.5) * 10,
          dy: (rand2 - 0.5) * 10);
    });
    objects = [
      ...rocks,
      ...papers,
      ...scissors,
    ];
  }
}
