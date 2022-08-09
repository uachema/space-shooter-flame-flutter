import 'dart:math';

class AsteroidsHelper {
  Map<String, dynamic> getRandomAsteroid() =>
      _asteroids[Random().nextInt(_asteroids.length)];
  final List<Map<String, dynamic>> _asteroids = [
    {
      'path': 'asteroid1.png',
      'category': AsteroidType.small,
      'size': 60,
      'hitboxRadius': 0.9,
      'hp': 2,
      'speed': 400,
      'reward': 5,
    },
    {
      'path': 'asteroid2.png',
      'category': AsteroidType.medium,
      'size': 90,
      'hitboxRadius': 0.9,
      'hp': 4,
      'speed': 300,
      'reward': 9,
    },
    {
      'path': 'asteroid3.png',
      'category': AsteroidType.big,
      'size': 120,
      'hitboxRadius': 0.85,
      'hp': 7,
      'speed': 200,
      'reward': 15,
    },
    {
      'path': 'asteroid4.png',
      'category': AsteroidType.small,
      'size': 60,
      'hitboxRadius': 0.9,
      'hp': 3,
      'speed': 400,
      'reward': 7,
    },
    {
      'path': 'asteroid5.png',
      'category': AsteroidType.big,
      'size': 100,
      'hitboxRadius': 0.85,
      'hp': 5,
      'speed': 200,
      'reward': 11,
    },
  ];
}

enum AsteroidType {
  small,
  medium,
  big,
}
