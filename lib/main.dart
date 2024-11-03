import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vente_vitment/view_model/current_page_view_model.dart';
import 'package:vente_vitment/view_model/panier_view_model.dart';
import 'package:vente_vitment/view_model/user_profil_view_model.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'view_model/vetement_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentPageViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => VetementViewModel()),
        ChangeNotifierProvider(create: (context) => PanierViewModel()),
        ChangeNotifierProvider(create: (context) => UserProfilViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color(0xFFfC9B92),
                primaryContainer: const Color.fromARGB(37, 252, 155, 146))),
        darkTheme: ThemeData.light(),
        home: const CurrentPage(),
      ),
    );
  }
}

class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget currentPage = context.watch<CurrentPageViewModel>().currentScreen;

    return currentPage;
  }
}
