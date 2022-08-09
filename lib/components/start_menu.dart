import 'package:flame/components.dart';

class StartMenu extends TextComponent {
  StartMenu(this.canvasSize) : super(anchor: Anchor.center);
  final Vector2 canvasSize;

  @override
  Future<void>? onLoad() {
    position = canvasSize / 2;
    text = "Tap To Start !";
    return super.onLoad();
  }
}
