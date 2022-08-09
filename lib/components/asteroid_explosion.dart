import 'dart:ui';
import 'package:flame/components.dart';

class AsteroidExplosion extends SpriteAnimationComponent {
  AsteroidExplosion({
    required Vector2 size,
    required this.onAnimationComplete,
  }) : super(
          size: size,
          position: (size) / 2,
          anchor: Anchor.center,
        );
  final VoidCallback onAnimationComplete;

  @override
  Future<void>? onLoad() async {
    animation = await SpriteAnimation.load(
      'animations/asteroid_explosion.png',
      SpriteAnimationData.sequenced(
        amountPerRow: 12,
        amount: 12,
        stepTime: 0.05,
        textureSize: Vector2.all(100),
        loop: false,
      ),
    );
    animation?.onComplete = onAnimationComplete;
    removeOnFinish = true;
    return super.onLoad();
  }
}
