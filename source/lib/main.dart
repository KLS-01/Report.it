import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/application/entity/entity_GA/super_utente.dart';
import 'package:report_it/firebase_options.dart';
import 'package:report_it/presentation/pages/pages_GA/authentication_wrapper.dart';
import 'package:report_it/presentation/widget/styles.dart';
import 'application/repository/authentication_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        StreamProvider<SuperUtente?>(
            create: (_) =>
                AuthenticationService(FirebaseAuth.instance).superUtenteStream,
            initialData: null)
      ],
      child: MaterialApp(
        title: 'Report.it',
        debugShowCheckedModeBanner: false,
        theme: ThemeText.theme,
        home: Scaffold(
          body: AuthenticationWrapper(),
        ),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [Locale('it')],
      ),
    );
  }
}
