import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/common/widgets/error.dart';
import 'package:new_chat_app/common/widgets/loader.dart';
import 'package:new_chat_app/core/configs/theme/app_theme.dart';
import 'package:new_chat_app/features/auth/controller/auth_controller.dart';
import 'package:new_chat_app/features/landing/screens.dart';
import 'package:new_chat_app/firebase_options.dart';
import 'package:new_chat_app/router.dart';
import 'package:new_chat_app/screens/mobile_layout_screen.dart';
import 'package:new_chat_app/them_notifier.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(
    child: MyApp()
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ref.watch(themeProvider),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
        data: (user) {
          if (user == null) {
            return const LandingScreen();
          }
          return const MobileLayoutScreen();
        },
        error: (err, trace) {
          return ErrorScreen(error: err.toString());
        },
        loading: () => const Loader(),
      ),
    );
  }
}