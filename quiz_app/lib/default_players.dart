class DefaultPlayer {
  final String name;
  final int score;
  final int health;

  DefaultPlayer(
      {required this.name, required this.score, required this.health});
}

final List<DefaultPlayer> defaultPlayers = [
  DefaultPlayer(name: "Captain America", score: 90, health: 2),
  DefaultPlayer(name: "Iron Man", score: 90, health: 2),
  DefaultPlayer(name: "Wonder Woman", score: 90, health: 2),
  DefaultPlayer(name: "Black Widow", score: 85, health: 2),
  DefaultPlayer(name: "Spider-Man", score: 80, health: 1),
  DefaultPlayer(name: "John Doe", score: 80, health: 2),
  DefaultPlayer(name: "Alice", score: 75, health: 1),
  DefaultPlayer(name: "Deadpool", score: 70, health: 1),
];
