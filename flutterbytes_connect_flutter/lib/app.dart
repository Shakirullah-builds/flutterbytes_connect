import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'features/wall/presentation/wall_page.dart';

class FlutterBytesConnectApp extends StatelessWidget {
  const FlutterBytesConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBytes Connect AI',
      debugShowCheckedModeBanner: false,
      theme: FbcTheme.darkTheme,
      darkTheme: FbcTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const WallPage(),
    );
  }
}
