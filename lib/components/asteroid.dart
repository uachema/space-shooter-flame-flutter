import 'dart:math' as math;
import 'package:first_flame_game/components/asteroid_explosion.dart';
import 'package:first_flame_game/components/fire_attack.dart';
import 'package:first_flame_game/utils/asteroid_helper.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Asteroid extends SpriteComponent with HasHitboxes, Collidable {
  Asteroid({
    required this.updateScore,
    required this.canvasSize,
    required this.path,
    required this.asteroidType,
    required this.hp,
    required this.hitboxRadius,
    required this.speed,
    required this.reward,
    required Vector2 size,
    required Vector2 position,
  }) : super(
          size: size,
          position: position,
          anchor: Anchor.center,
        );
  final Function updateScore;
  final Vector2 canvasSize;
  final String path;
  double hitboxRadius;
  int hp, reward;
  AsteroidType asteroidType;
  final double speed;
  bool _destroyed = false;

  void destroy() async {
    _destroyed = true;
    angle = 0.0;
    updateScore(reward);
    sprite = await Sprite.load('blank.png');
    add(
      AsteroidExplosion(
        size: size,
        onAnimationComplete: () {
          removeFromParent();
        },
      ),
    );
  }

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load(path);
    addHitbox(HitboxCircle(normalizedRadius: hitboxRadius));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is FireAttack) {
      hp -= other.damage;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (!_destroyed) {
      angle += 0.25 * dt;
      angle %= 2 * math.pi;
      position += Vector2(0, 1) * speed * dt;
      if (hp <= 0) destroy();
      if (position.y > canvasSize.y + size.y) removeFromParent();
    }
    super.update(dt);
  }
}
