import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/common.dart';
import '../widgets/inputs.dart';
import '../config/theme.dart';

class PunishmentsScreen extends StatefulWidget {
  const PunishmentsScreen({super.key});
  @override
  State<PunishmentsScreen> createState() => _PunishmentsScreenState();
}

class _PunishmentsScreenState extends State<PunishmentsScreen> {
  final _controller = TextEditingController();

  void _add(GameProvider game) {
    if (_controller.text.trim().isEmpty) return;
    game.addPunishment(_controller.text.trim());
    _controller.clear();
    FocusScope.of(context).unfocus(); // Ocultar teclado
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);
    
    return Scaffold(
      body: GameBackground(
        child: Column(
          children: [
            GameNavBar(
              title: "Editar Castigos", 
              onBack: () => Navigator.pop(context),
              action: IconButton(
                icon: const Icon(Icons.restore, color: AppColors.error),
                onPressed: () => _confirmReset(context, game),
                tooltip: "Restaurar originales",
              ),
            ),
            
            // Input para agregar nuevo
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                Expanded(child: MinimalInput(controller: _controller, hint: "Nuevo castigo (ej: Pagar los tacos)")),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: AppColors.accent, size: 40),
                  onPressed: () => _add(game),
                )
              ]),
            ),

            // Lista de castigos
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: game.punishments.length,
                separatorBuilder: (_,__) => const SizedBox(height: 10),
                itemBuilder: (ctx, i) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => game.removePunishment(i),
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: GameCard(
                      child: Row(children: [
                        Text("${i + 1}.", style: const TextStyle(color: Colors.white30, fontFamily: 'Bungee')),
                        const SizedBox(width: 15),
                        Expanded(child: Text(game.punishments[i], style: const TextStyle(fontFamily: 'YoungSerif', fontSize: 16))),
                      ]),
                    ),
                  );
                },
              ),
            ),
            
            // Nota informativa
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text("Desliza para borrar", style: AppTheme.body(12), textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, GameProvider game) {
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgBottom,
        title: const Text("¿Restaurar?", style: TextStyle(color: Colors.white, fontFamily: 'Bungee')),
        content: const Text("Se borrarán tus castigos personalizados y volverán los originales.", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: const Text("CANCELAR")),
          TextButton(onPressed: () { game.resetPunishments(); Navigator.pop(context); }, child: const Text("RESTAURAR", style: TextStyle(color: AppColors.error))),
        ],
      )
    );
  }
}
