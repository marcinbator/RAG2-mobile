import '../models/game.dart';

List<Game> games = [
  Game(
      'Pong',
      '/pong',
      [GameButton("Up", "move", 1), GameButton("Down", "move", -1)],
      true,
      false),
  Game('Flappybird', '/flappy', [GameButton("Jump", "jump", 1)], false, false),
];
