import 'package:first_flame_game/components/asteroid.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class FireAttack extends SpriteComponent with HasHitboxes, Collidable {
  FireAttack({required Vector2 position})
      : super(
          size: Vector2(10, 20),
          position: position,
        );
  final double _speed = 400;
  int damage = 1;

  @override
  Future<void>? onLoad() async {
    addHitbox(HitboxRectangle());
    sprite = await Sprite.load('fire.png');
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Asteroid) {
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position += Vector2(0, -1) * _speed * dt;
    if (position.y < 0) removeFromParent();
    super.update(dt);
  }
}
