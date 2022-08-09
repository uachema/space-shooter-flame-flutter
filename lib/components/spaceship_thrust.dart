import 'package:flame/components.dart';

class SpaceshipThrust extends SpriteAnimationComponent {
  SpaceshipThrust({required Vector2 position})
      : super(
          size: Vector2.all(30),
          anchor: Anchor.center,
          position: position,
        );
  @override
  Future<void>? onLoad() async {
    animation = await SpriteAnimation.load(
      'animations/rocket_thrust.png',
      SpriteAnimationData.sequenced(
        amountPerRow: 1,
        amount: 3,
        stepTime: 0.05,
        textureSize: Vector2.all(200),
      ),
    );
    return super.onLoad();
  }
}
