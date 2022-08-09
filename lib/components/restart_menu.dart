import 'package:flame/components.dart';

class RestartMenu extends TextComponent {
  RestartMenu(this.canvasSize) : super(anchor: Anchor.center);
  final Vector2 canvasSize;

  @override
  Future<void>? onLoad() {
    position = canvasSize / 2;
    text = "Tap To Play Again !";
    return super.onLoad();
  }
}
