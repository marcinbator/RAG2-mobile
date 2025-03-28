class Game {
  final String name;
  final String path;
  final List<GameButton> buttons;
  final bool tilt;
  final bool tiltUseXAxis;

  const Game(this.name, this.path, this.buttons, this.tilt, this.tiltUseXAxis);
}

class GameButton {
  final String text;
  final String actionName;
  final double action;

  const GameButton(this.text, this.actionName, this.action);
}
