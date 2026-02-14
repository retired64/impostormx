import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:impostormx/main.dart'; // Tu archivo main
import 'package:impostormx/providers/game_provider.dart'; // Tu provider

void main() {
  testWidgets('Prueba de inicio de Impostor MX', (WidgetTester tester) async {
    // 1. Envolvemos la app en el GameProvider para que no tire error
    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => GameProvider())],
        child:
            const ImpostorApp(), // <-- Asegúrate de que este sea el nombre de tu clase principal en main.dart
      ),
    );

    // 2. Verificamos que cargue la pantalla principal buscando un texto que SÍ existe
    expect(find.text('Elige un tema'), findsOneWidget);
  });
}
