import 'dart:math';
import 'package:first_flame_game/components/asteroid.dart';
import 'package:first_flame_game/components/fire_attack.dart';
import 'package:first_flame_game/components/meteor.dart';
import 'package:first_flame_game/components/restart_menu.dart';
import 'package:first_flame_game/components/score.dart';
import 'package:first_flame_game/components/spaceship.dart';
import 'package:first_flame_game/components/start_menu.dart';
import 'package:first_flame_game/utils/asteroid_helper.dart';
import 'package:first_flame_game/utils/ship_position.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main(List<String> args) {
  runApp(GameWidget(
    game: MyGame(),
    // overlayBuilderMap: {
    // 'PauseMenu': (ctx) {
    // return Text('A pause menu');
    // },
    // },
  ));
}

class MyGame extends FlameGame
    with TapDetector, HasKeyboardHandlerComponents, HasCollidables {
  final _asteroidsHelper = AsteroidsHelper();
  Score _score = Score();
  Component _startMenu = Component();
  Component _restartMenu = Component();
  bool dead = false;
  bool gameStarted = false;

  @override
  Future<void>? onLoad() async {
    final parallax = await loadParallaxComponent(
      [ParallaxImageData('space.jpg')],
      baseVelocity: Vector2(0, -100),
      repeat: ImageRepeat.repeatY,
      // velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    _score = Score();
    _startMenu = StartMenu(canvasSize);
    _restartMenu = RestartMenu(canvasSize);
    add(_score);
    add(parallax);
    add(_startMenu);
    return super.onLoad();
  }

  @override
  void onTap() {
    if (!gameStarted) {
      dead = false;
      _startMenu.removeFromParent();
      startGame(_score);
    } else if (dead) {
      dead = false;
      _restartMenu.removeFromParent();
      _score.updateScore(0);
      startGame(_score);
    } else {
      add(FireAttack(position: shipPosition));
    }
    super.onTap();
  }

  void startGame(Score score) {
    gameStarted = true;
    add(Spaceship(endGame: () {
      dead = true;
      add(_restartMenu);
    }));
    spawnMeteors();
    spawnAsteroids(score);
  }

  void spawnMeteors() {
    if (!dead) {
      int random = Random().nextInt(400);
      int nextDelay = Random().nextInt(4);
      bool showMeteor = Random().nextBool();
      if (showMeteor && !dead) {
        add(Meteor(
          canvasSize: camera.canvasSize,
          size: Vector2.all(100),
          position: Vector2(camera.canvasSize.x, random * 1.0),
        ));
      }
      Future.delayed(
        Duration(seconds: nextDelay),
        () => spawnMeteors(),
      );
    }
  }

  void spawnAsteroids(Score score) {
    if (!dead) {
      int randomXPosition = Random().nextInt(camera.canvasSize.x.round());
      Map asteroid = _asteroidsHelper.getRandomAsteroid();
      int nextDelay = Random().nextInt(4);
      add(Asteroid(
        canvasSize: canvasSize,
        path: asteroid['path'],
        asteroidType: asteroid['category'],
        hp: asteroid['hp'],
        hitboxRadius: asteroid['hitboxRadius'],
        size: Vector2.all(asteroid['size'] * 1.0),
        speed: asteroid['speed'] * 1.0,
        reward: asteroid['reward'],
        position: Vector2(
          randomXPosition * 1.0,
          -asteroid['size'] * 1.0,
        ),
        updateScore: score.updateScore,
      ));

      Future.delayed(
        Duration(seconds: nextDelay),
        () => spawnAsteroids(score),
      );
    }
  }
}
