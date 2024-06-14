import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogo/services/auth_service.dart';
import 'package:jogo/screens/login_screen.dart';
import 'package:jogo/screens/register_screen.dart';
import 'package:jogo/screens/game_screen.dart';
import 'package:jogo/screens/ranking_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPv4 Game',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/game': (context) => GameScreen(),
        '/ranking': (context) => RankingScreen(),
      },
    );
  }
  //sougayola
}
