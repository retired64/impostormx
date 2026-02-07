import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import '../providers/game_provider.dart';
import '../widgets/inputs.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'category_screen.dart';

class ResultScreen extends StatelessWidget {
  final Player votedPlayer;
  const ResultScreen({super.key, required this.votedPlayer});
  @override
  Widget build(BuildContext context) {
    final bool isImpostor = votedPlayer.role == 'impostor';
    final color = isImpostor ? AppColors.accent : AppColors.error;
    final winnerText = isImpostor ? "¡GANAN LOS CIVILES!" : "¡GANA EL IMPOSTOR!";
    final loserTitle = isImpostor ? "Castigo para el IMPOSTOR" : "Castigo para los CIVILES";

    return Scaffold(
      body: Container(color: color, child: SafeArea(child: Column(children: [
        const SizedBox(height: 20),
        Icon(isImpostor ? Icons.check_circle_outline : Icons.cancel_outlined, size: 80, color: Colors.black),
        Text(winnerText, textAlign: TextAlign.center, style: AppTheme.heading(28).copyWith(color: Colors.black)),
        
        const SizedBox(height: 20),
        Expanded(child: Container(margin: const EdgeInsets.symmetric(horizontal: 20), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30)), child: Column(children: [Text("💀 EL CASTIGO", style: TextStyle(color: color, fontWeight: FontWeight.bold, letterSpacing: 2)), Text(loserTitle, style: const TextStyle(color: Colors.white54, fontSize: 12)), const Spacer(), const PunishmentRoulette(), const Spacer()]))),

        Padding(padding: const EdgeInsets.all(20), child: Row(children: [
          Expanded(child: TextButton(onPressed: () { Provider.of<GameProvider>(context, listen: false).exitGame(); Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const CategoryScreen()), (r) => false); }, child: const Text("SALIR", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)))),
          const SizedBox(width: 20),
          Expanded(child: BouncyButton(text: "OTRA VEZ", color: Colors.black, onPressed: () { Provider.of<GameProvider>(context, listen: false).prepareNewMatch(); Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const CategoryScreen()), (r) => false); })),
        ]))
      ]))),
    );
  }
}

class PunishmentRoulette extends StatefulWidget {
  const PunishmentRoulette({super.key});
  @override
  State<PunishmentRoulette> createState() => _PunishmentRouletteState();
}

class _PunishmentRouletteState extends State<PunishmentRoulette> {
  String _currentText = "???"; bool _isSpinning = false; bool _hasSpun = false;
  void _spin() async {
    setState(() => _isSpinning = true);
    final random = Random(); int ticks = 30 + random.nextInt(10); int delay = 50;
    for (int i = 0; i < ticks; i++) {
      await Future.delayed(Duration(milliseconds: delay)); if (!mounted) return;
      setState(() { _currentText = GameConstants.punishments[random.nextInt(GameConstants.punishments.length)]; });
      Vibration.vibrate(duration: 15);
      if (i > ticks - 10) delay += 30; if (i > ticks - 5) delay += 60;
    }
    if (!mounted) return; Vibration.vibrate(pattern: [0, 50, 100, 500]); setState(() { _isSpinning = false; _hasSpun = true; });
  }
  @override
  Widget build(BuildContext context) {
    if (!_isSpinning && !_hasSpun) return BouncyButton(text: "GIRAR RULETA 😈", color: AppColors.accent, onPressed: _spin);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      AnimatedContainer(duration: const Duration(milliseconds: 100), transform: Matrix4.identity()..scale(_isSpinning ? 1.05 : 1.0), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20), border: Border.all(color: _isSpinning ? AppColors.accent : Colors.white24, width: 2)), child: Text(_currentText, textAlign: TextAlign.center, style: GoogleFonts.fredoka(fontSize: 24, color: Colors.white))),
      if (_hasSpun) ...[const SizedBox(height: 10), TextButton.icon(onPressed: _spin, icon: const Icon(Icons.refresh, color: Colors.white54), label: const Text("Girar de nuevo", style: TextStyle(color: Colors.white54)))]
    ]);
  }
}
