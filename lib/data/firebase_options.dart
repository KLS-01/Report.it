// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA3ru7pWEjEka2cbPpdEnfo34gYMSuzs9M',
    appId: '1:1014330151731:web:9b40248fd736e8b886e446',
    messagingSenderId: '1014330151731',
    projectId: 'reportit-unisa',
    authDomain: 'reportit-unisa.firebaseapp.com',
    storageBucket: 'reportit-unisa.appspot.com',
    measurementId: 'G-479CCJG3RF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5Pi4hQevrnm13d6zkpT17ZkMQvv-tZ3U',
    appId: '1:1014330151731:android:d2bbfb1b053e04f586e446',
    messagingSenderId: '1014330151731',
    projectId: 'reportit-unisa',
    storageBucket: 'reportit-unisa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJcxTY_D1r10AAuJL0WC2uGIPBVT9yaes',
    appId: '1:1014330151731:ios:39c92d64411226da86e446',
    messagingSenderId: '1014330151731',
    projectId: 'reportit-unisa',
    storageBucket: 'reportit-unisa.appspot.com',
    iosClientId:
        '1014330151731-plagr4r3pce5kdisvr8n5cgss8dkkfqr.apps.googleusercontent.com',
    iosBundleId: 'com.example.reportIt',
  );
}