/*
 * Impostor MX - Juego de fiesta libre y gratuito
 * Copyright (C) 2026 Retired64 
 *
 * Este programa es software libre: puedes redistribuirlo y/o modificarlo
 * bajo los términos de la Licencia Pública General GNU publicada por
 * la Free Software Foundation, ya sea la versión 3 de la Licencia, o
 * (a tu elección) cualquier versión posterior.
 *
 * Este programa se distribuye con la esperanza de que sea útil,
 * pero SIN NINGUNA GARANTÍA; sin siquiera la garantía implícita de
 * COMERCIABILIDAD o APTITUD PARA UN PROPÓSITO PARTICULAR. Consulta la
 * Licencia Pública General GNU para más detalles.
 *
 * Deberías haber recibido una copia de la Licencia Pública General GNU
 * junto con este programa. Si no es así, consulta <https://www.gnu.org/licenses/>.
 */

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
