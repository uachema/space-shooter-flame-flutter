import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Meteor extends SpriteComponent with HasHitboxes, Collidable {
  Meteor({
    required this.canvasSize,
    required Vector2 position,
    required Vector2 size,
  }) : super(
          size: size,
          position: position,
          anchor: Anchor.center,
        );
  final Vector2 canvasSize;
  final double _vSpeed = 350;
  final double _hSpeed = 200;

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('meteor.png');
    addHitbox(HitboxCircle(normalizedRadius: 0.45));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += Vector2(0, 1) * _vSpeed * dt;
    position += Vector2(-1, 0) * _hSpeed * dt;
    if (position.y > canvasSize.y + 100) removeFromParent();
    if (position.x < -100) removeFromParent();
    super.update(dt);
  }
}
