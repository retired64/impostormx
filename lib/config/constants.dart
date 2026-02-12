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

class GameConstants {
  static const int minPlayers = 3;
  static const int pinLength = 4;
  static const int defaultTimeSeconds = 180;
  static const String prefsCustomCategories = 'custom_categories_v2';
  static const String prefsPunishments = 'custom_punishments';

  // Feedback Háptico
  static const List<int> hapticTap = [0, 10];
  static const List<int> hapticSuccess = [0, 40, 60, 40];
  static const List<int> hapticError = [0, 50, 50, 50, 50, 50];
  static const List<int> hapticAlarm = [0, 500, 200, 500, 200, 1000];
  static const List<int> hapticPeek = [0, 20];

  static const List<String> punishments = [
    "🍺 ¡Fondo a tu bebida!",
    "💃 Baila 'La Pelusa' 30 segundos",
    "🏋️ Haz 10 sentadillas ahora mismo",
    "📱 Deja que lean tu último WhatsApp",
    "🐔 Imita a una gallina poniendo un huevo",
    "🧊 Mastica un hielo hasta que se derrita",
    "🎤 Canta el coro de tu canción favorita",
    "😳 Confiesa tu gusto culposo más raro",
    "📸 Sube una selfie haciendo muecas",
    "🤫 Quédate callado toda la siguiente ronda",
    "🤸 Haz 5 lagartijas (flexiones)",
    "🫂 Abraza al jugador de tu derecha",
  ];
}
