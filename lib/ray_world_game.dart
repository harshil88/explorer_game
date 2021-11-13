import 'package:flame/game.dart';
import 'package:rayworld/components/world.dart';
import 'components/player.dart';
import 'helpers/direction.dart';
import 'dart:ui';
import 'components/world_collidable.dart';
import 'helpers/map_loader.dart';
import 'package:flame/components.dart';



class RayWorld extends FlameGame with HasCollidables{

  final World _world = World();
  final Player _player = Player();

  @override
  Future<void>? onLoad() async{
    await add(_world);
    add(_player);
    _player.position = _world.size / 2;
    camera.followComponent(
      _player,
      worldBounds:  Rect.fromLTRB(0, 0, _world.size.x, _world.size.y),
    );
    addWorldCollision();
  }

  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });


  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }
}

