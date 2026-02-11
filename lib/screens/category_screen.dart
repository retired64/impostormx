import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/common.dart';
import '../config/theme.dart';
import '../words.dart';
import 'create_category_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);
    return Scaffold(
      body: GameBackground(
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
                      Text("impostormx.store", style: AppTheme.body(14)),
                      Text("Elige un tema", style: AppTheme.heading(32)),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: game.allCategories.length,
                itemBuilder: (ctx, i) {
                  final cat = game.allCategories[i];
                  return GameCard(
                    onTap: () {
                      game.selectedCategory = cat;
                      Navigator.pushNamed(context, '/players');
                    },
                    onLongPress: i >= GAME_CATEGORIES.length
                        ? () => _showOptions(context, game, cat)
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(cat.icon, style: const TextStyle(fontSize: 50)),
                        const SizedBox(height: 15),
                        Text(
                          cat.name,
                          textAlign: TextAlign.center,
                          style: AppTheme.heading(18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${cat.words.length} cartas",
                          style: AppTheme.body(12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
                style: TextStyle(color: Colors.white),
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
                style: TextStyle(color: Colors.white),
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
