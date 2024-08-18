import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playCorrectSound() async {
    await _audioPlayer.play(AssetSource('sounds/correct.mp3'));
  }

  static Future<void> playWrongSound() async {
    await _audioPlayer.play(AssetSource('sounds/wrong.mp3'));
  }

  static Future<void> playGameOverSound() async {
    await _audioPlayer.play(AssetSource('sounds/game_over.mp3'));
  }
}
