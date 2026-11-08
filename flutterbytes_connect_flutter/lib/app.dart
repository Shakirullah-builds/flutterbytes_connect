import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: const WallPage(),
    );
  }
}
