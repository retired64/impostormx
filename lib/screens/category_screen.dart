import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/common.dart';
import '../config/theme.dart';
import '../words.dart';
import 'create_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Estado para controlar si se muestra el tutorial
  bool _showTutorial = false;

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);

    return Scaffold(
      // BOTÓN FLOTANTE DE AYUDA (Solo aparece si no hay tutorial activo)
      floatingActionButton: _showTutorial
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.accent,
              onPressed: () => setState(() => _showTutorial = true),
              child: const Icon(
                Icons.help_outline,
                color: Colors.black,
                size: 30,
              ),
            ),

      body: Stack(
        children: [
          // 1. EL CONTENIDO PRINCIPAL (Tu pantalla original)
          GameBackground(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "impostormx.store",
                            style: TextStyle(
                              fontFamily: 'YoungSerif',
                              fontSize: 14,
                              color: AppColors.textDim,
                            ),
                          ),
                          Text(
                            "Elige un tema",
                            style: TextStyle(
                              fontFamily: 'Bungee',
                              fontSize: 32,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateCategoryScreen(),
                          ),
                        ),
                        icon: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: AppColors.accent),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: game.allCategories.length,
                    itemBuilder: (ctx, i) {
                      final cat = game.allCategories[i];
                      final isCustom = i >= GAME_CATEGORIES.length;
                      return GestureDetector(
                        onTap: () {
                          game.selectCategory(cat);
                          Navigator.pushNamed(context, '/players');
                        },
                        onLongPress: isCustom
                            ? () => _showOptions(context, game, cat)
                            : null,
                        child: Container(
                          decoration: BoxDecoration(
                            color: cat.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: cat.color.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cat.icon,
                                style: const TextStyle(fontSize: 50),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                cat.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Bungee',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${cat.words.length} cartas",
                                style: const TextStyle(
                                  fontFamily: 'YoungSerif',
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 2. LA CAPA OSCURA DE FONDO (Para resaltar el tutorial)
          if (_showTutorial)
            GestureDetector(
              onTap: () => setState(
                () => _showTutorial = false,
              ), // Cerrar al tocar fuera
              child: Container(
                color: Colors.black87,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          // 3. EL CUADRO DE TUTORIAL FLOTANTE
          if (_showTutorial)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _TutorialCard(
                  onClose: () => setState(() => _showTutorial = false),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context, GameProvider game, Category cat) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.bgBottom,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.accent),
              title: const Text(
                "Editar",
                style: TextStyle(color: Colors.white, fontFamily: 'YoungSerif'),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateCategoryScreen(categoryToEdit: cat),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.error),
              title: const Text(
                "Eliminar",
                style: TextStyle(color: Colors.white, fontFamily: 'YoungSerif'),
              ),
              onTap: () {
                Navigator.pop(context);
                game.deleteCustomCategory(cat.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGET INTERNO DEL TUTORIAL ---
class _TutorialCard extends StatefulWidget {
  final VoidCallback onClose;
  const _TutorialCard({required this.onClose});

  @override
  State<_TutorialCard> createState() => _TutorialCardState();
}

class _TutorialCardState extends State<_TutorialCard> {
  int _currentStep = 0;

  final List<Map<String, String>> _steps = [
    {
      "title": "PASO 1",
      "text":
          "Elige una categoría temática para jugar. ¡Puedes crear las tuyas propias con el botón '+' de arriba!",
    },
    {
      "title": "PASO 2",
      "text":
          "Pasa el celular para que cada uno configure su nombre y PIN, una vez completado dale em continuar y configura cuántos Impostores habrá en la partida. ahí mismo puedes configurar el tiempo de debate y poner tus propios castigos de la ruleta.",
    },
    {
      "title": "PASO 3",
      "text":
          "Pasen el celular. Cada jugador deberá ingresar su PIN, una vez completado verá su palabra secreta, pero... ¡El Impostor no verá nada!",
    },
    {
      "title": "PASO 4",
      "text":
          "¡A debatir! Hagan preguntas y describan su palabra sin ser muy obvios para no ayudar al Impostor.",
    },
    {
      "title": "PASO 5",
      "text":
          "Cuando el tiempo acabe, voten por quien crean que miente. ¡Si atrapan al Impostor, ganan los civiles! Si el Impostor sobrevive, gana él! El perdedor de la partida tendrá que girar la ruleta de castigos... ¡Suerte!",
    },
  ];

  void _next() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      widget.onClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    final isLast = _currentStep == _steps.length - 1;

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.bgBottom,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.accent, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera: Título y Cerrar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                step["title"]!,
                style: const TextStyle(
                  fontFamily: 'Bungee',
                  fontSize: 24,
                  color: AppColors.accent,
                ),
              ),
              IconButton(
                onPressed: widget.onClose,
                icon: const Icon(Icons.close, color: Colors.white54),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Texto del paso
          Text(
            step["text"]!,
            style: const TextStyle(
              fontFamily: 'YoungSerif',
              fontSize: 18,
              color: Colors.white,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 30),

          // Barra de progreso y botón
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Indicador de puntitos (opcional pero se ve pro)
              Row(
                children: List.generate(
                  _steps.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 6),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentStep
                          ? Colors.white
                          : Colors.white24,
                    ),
                  ),
                ),
              ),

              // Botón de acción
              ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLast ? AppColors.error : AppColors.accent,
                  foregroundColor: isLast ? Colors.white : Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isLast ? "FINALIZAR" : "SIGUIENTE",
                  style: const TextStyle(fontFamily: 'Bungee', fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
