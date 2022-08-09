import 'package:flame/components.dart';

class Score extends TextComponent {
  Score() : super(size: Vector2.all(20), priority: 1);
  Vector2 screenSize = Vector2(0.0, 0.0);
  int score = 0;

  void updateScore(int reward) {
    reward == 0 ? score = 0 : score += reward;
    if (score >= 1000) {
      position.x = screenSize.x - 150;
    } else if (score >= 100) {
      position.x = screenSize.x - 135;
    } else if (score >= 10) {
      position.x = screenSize.x - 120;
    } else {
      position.x = screenSize.x - 110;
    }
    text = 'Score : $score';
  }

  @override
  Future<void>? onLoad() {
    text = 'Score : $score';
    position = Vector2(screenSize.x - 110, 16.0);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    screenSize = gameSize;
    super.onGameResize(gameSize);
  }
}
