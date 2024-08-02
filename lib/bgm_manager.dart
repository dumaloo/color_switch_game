import 'package:flame_audio/flame_audio.dart';

class BgmManager {
  static void play(String fileName) {
    FlameAudio.bgm.stop();
    FlameAudio.bgm.play(fileName);
  }

  static void stop() {
    FlameAudio.bgm.stop();
  }

  static void pause() {
    FlameAudio.bgm.pause();
  }

  static void resume() {
    FlameAudio.bgm.resume();
  }
}
