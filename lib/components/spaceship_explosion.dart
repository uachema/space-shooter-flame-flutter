import 'dart:ui';
import 'package:flame/components.dart';

class SpaceshipExplosion extends SpriteAnimationComponent {
  SpaceshipExplosion({
    required Vector2 size,
    required this.onAnimationComplete,
  }) : super(
          size: size,
          position: (size) / 2.4,
          anchor: Anchor.center,
        );
  final VoidCallback onAnimationComplete;

  @override
  Future<void>? onLoad() async {
    animation = await SpriteAnimation.load(
      'animations/spaceship_explosion.png',
      SpriteAnimationData.sequenced(
        amountPerRow: 5,
        amount: 20,
        stepTime: 0.05,
        textureSize: Vector2.all(190),
        loop: false,
      ),
    );
    animation?.onComplete = onAnimationComplete;
    removeOnFinish = true;
    return super.onLoad();
  }
}
