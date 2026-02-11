import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  // Creamos una única instancia para toda la app
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playClick() async {
    // Si ya está sonando, lo detenemos para reiniciar (útil para clicks rápidos)
    if (_player.state == PlayerState.playing) {
      await _player.stop();
    }
    // Ajusta el volumen si es necesario (0.0 a 1.0)
    await _player.play(AssetSource('sounds/click.mp3'), volume: 0.5);
  }
}
