import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC1x42OQZL0_Lti4Sup6P0o-7foEgLgTSI',
      appId: '1:1039234485846:web:984e1d43ca5e13049c35f7',
      messagingSenderId: '1039234485846',
      projectId: 'orqua-704be',
    ),
  );

  await DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DependencyInjection.authProvider),
        ChangeNotifierProvider.value(value: DependencyInjection.catalogProvider),
        ChangeNotifierProvider.value(value: DependencyInjection.cartProvider),
        ChangeNotifierProvider.value(value: DependencyInjection.ordersProvider),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'ShopFlutter',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            routerConfig: AppRouter.router(context),
          );
        },
      ),
    );
  }
}
