import 'bindings/general_bindings.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import '/utils/theme/theme.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const OnBoardingScreen(),
    );
  }
}
