import 'dart:ui';

class ObjectModel {
  final int id;
  final Color color;
  final ObjectType type;
  double x;
  double y;
  double dx;
  double dy;

  ObjectModel.create({
    required this.id,
    required this.type,
    required this.color,
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
  });
}

enum ObjectType { rock, paper, scissor }
