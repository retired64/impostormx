import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/common.dart';
import '../widgets/inputs.dart';
import '../config/theme.dart';
import 'login_screen.dart';
import 'punishments_screen.dart'; // <--- IMPORTANTE: Importamos la nueva pantalla

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);
    return Scaffold(
      body: GameBackground(
        child: Column(
          children: [
            GameNavBar(
              title: "Configuración",
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Counter(
                      "Impostores",
                      "${game.impostorCount}",
                      game.adjustImpostors,
                    ),
                    const SizedBox(height: 20),
                    _Counter(
                      "Tiempo",
                      "${(game.initialTimeSeconds / 60).floor()}:${(game.initialTimeSeconds % 60).toString().padLeft(2, '0')}",
                      (d) => game.adjustTime(d * 30),
                    ),

                    // --- NUEVO BOTÓN PARA EDITAR CASTIGOS ---
                    const SizedBox(height: 30),
                    GameCard(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PunishmentsScreen(),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Editar Castigos",
                            style: TextStyle(
                              fontFamily: 'Bungee',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Icon(Icons.edit_note, color: AppColors.accent),
                        ],
                      ),
                    ),
                    // ----------------------------------------
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: BouncyButton(
                text: "COMENZAR PARTIDA",
                onPressed: () {
                  game.startGame();
                  // Usamos pushAndRemoveUntil para reiniciar la pila de navegación
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (r) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  final String label;
  final String value;
  final Function(int) onChange;
  const _Counter(this.label, this.value, this.onChange);

  @override
  Widget build(BuildContext context) {
    return GameCard(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _RoundBtn(icon: Icons.remove, onTap: () => onChange(-1)),
              Text(value, style: AppTheme.heading(36)),
              _RoundBtn(icon: Icons.add, onTap: () => onChange(1)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundBtn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
