import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/data/Models/AutenticazioneDAO.dart';
import 'package:report_it/data/Models/forum_dao.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';
import 'package:report_it/firebase_options.dart';
import 'package:report_it/presentation/pages/authentication_wrapper.dart';
import 'domain/repository/authentication_service.dart';
import 'package:report_it/presentation/widget/theme.dart';

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
        theme: AppTheme().build(),
        home: Scaffold(
          body: AuthenticationWrapper(),
        ),
      ),
    );
  }
}
