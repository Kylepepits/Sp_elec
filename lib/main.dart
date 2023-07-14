import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course_rtk/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course_rtk/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course_rtk/state/providers/is_loading_provider.dart';
import 'package:instagram_clone_course_rtk/views/components/loading/loading_screen.dart';
import 'package:instagram_clone_course_rtk/views/login/login_view.dart';
import 'package:instagram_clone_course_rtk/views/main/main_view.dart';
import 'firebase_options.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: App()
    )
    );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, child){
        ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                );
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );
        final isLoggedIn = ref.watch(authStateProvider).result == AuthResult.success;
        isLoggedIn.log();
        if(isLoggedIn){
          return const MainView();
        }else {
          return const LoginView();
        }
      },
      ),
    );
  }
}



