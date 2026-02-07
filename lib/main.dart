import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'providers/game_provider.dart';
import 'screens/category_screen.dart';
import 'screens/player_setup_screen.dart';
import 'screens/config_screen.dart';
import 'screens/login_screen.dart';
import 'screens/reveal_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/voting_screen.dart';
// import 'screens/result_screen.dart'; // No necesitamos importarlo aquí si no está en las rutas estáticas

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GameProvider())],
      child: const ImpostorApp(),
    ),
  );
}

class ImpostorApp extends StatelessWidget {
  const ImpostorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Impostor MX',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const CategoryScreen(),
        '/players': (context) => const PlayerSetupScreen(),
        '/config': (context) => const ConfigScreen(),
        '/login': (context) => const LoginScreen(),
        '/reveal': (context) => const RevealScreen(),
        '/timer': (context) => const TimerScreen(),
        '/voting': (context) => const VotingScreen(),
        // La ruta '/result' se eliminó porque requiere argumentos dinámicos (el jugador votado).
        // Se llama manualmente desde VotingScreen.
      },
    );
  }
}
