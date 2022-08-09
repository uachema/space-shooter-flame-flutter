import 'dart:async';

import 'package:first_flame_game/components/asteroid.dart';
import 'package:first_flame_game/components/spaceship_explosion.dart';
import 'package:first_flame_game/components/fire_attack.dart';
import 'package:first_flame_game/components/meteor.dart';
import 'package:first_flame_game/components/spaceship_thrust.dart';
import 'package:first_flame_game/utils/ship_position.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Spaceship extends SpriteComponent
    with KeyboardHandler, HasHitboxes, Collidable {
  Spaceship({
    required this.endGame,
  }) : super(size: Vector2.all(60));
  Vector2 screenSize = Vector2(0.0, 0.0);
  final Function endGame;
  final double _speed = 150;
  final Vector2 _velocity = Vector2.zero();
  bool dead = false;
  Component _spaceshipThrust = Component();
  double accelerometerLastValue = 0.0;
  double accelerometerValue = 0.0;
  double toMove = 0.0;

  int _hAxisInput = 0;

  void shoot() => parent?.add(FireAttack(position: shipPosition));

  void die() async {
    dead = true;
    sprite = await Sprite.load('blank.png');
    _spaceshipThrust.removeFromParent();
    add(
      SpaceshipExplosion(
        size: size * 1.2,
        onAnimationComplete: () {
          endGame();
          removeFromParent();
        },
      ),
    );
  }

  @override
  Future<void>? onLoad() async {
    accelerometerEvents.listen(
      (event) {
        toMove += event.x;
        accelerometerValue = event.x;
      },
    );
    dead = false;
    sprite = await Sprite.load('space_ship.png');
    _spaceshipThrust = SpaceshipThrust(
      position: Vector2((size.x / 2) + 8, size.y + 10),
    );
    add(_spaceshipThrust);
    anchor = Anchor.center;
    addHitbox(HitboxCircle(normalizedRadius: 0.8));
    position = Vector2(
      screenSize.x / 2,
      screenSize.y - 60,
    );
    shipPosition = position.clone();
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Meteor || other is Asteroid) die();
  }

//   userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//   print(event);
// });

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    _hAxisInput = 0;
    // bool isKeyDown = event is RawKeyDownEvent;
    bool leftArrowPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    bool rightArrowPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    bool spacePressed = keysPressed.contains(LogicalKeyboardKey.space);
    // if (isKeyDown) {
    if (leftArrowPressed && !dead) _hAxisInput = -1;
    if (rightArrowPressed && !dead) _hAxisInput = 1;
    if (spacePressed && !dead) shoot();
    // }
    return true;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    // We don't need to set the position in the constructor, we can set it directly here since it will
    // be called once before the first time it is rendered.
    screenSize = gameSize;
    // position = gameSize / 2;
  }

  @override
  void update(double dt) {
    // if ((position.x > 30 || _hAxisInput == 1) &&
    //     (position.x < screenSize.x - 30 || _hAxisInput == -1)) {
    //   _velocity.x = _speed * _hAxisInput;
    //   position += _velocity * dt;
    // }
    if (!dead) {
      if ((position.x > 30 || accelerometerValue < 0) &&
          (position.x < screenSize.x - 30 || accelerometerValue > 0)) {
        _velocity.x = _speed * -accelerometerValue;
        position += (_velocity * dt);
        // _velocity.x = _speed * _hAxisInput;
        // position += _velocity * dt;
      }
    }
    shipPosition = position.clone();
    super.update(dt);
  }
}
