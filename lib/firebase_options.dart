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
        return macos;
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
    apiKey: 'AIzaSyCIWI_HxyAjxPU5srKqVGfsDsS92J2RlIw',
    appId: '1:516446699630:web:d2d6bda34d44bb0d7ee67f',
    messagingSenderId: '516446699630',
    projectId: 'budgetapp-8c69e',
    authDomain: 'budgetapp-8c69e.firebaseapp.com',
    storageBucket: 'budgetapp-8c69e.appspot.com',
    measurementId: 'G-B774KGE51W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpCbqbIw5-5dytE7oafEjpt2kCDe7T2ZY',
    appId: '1:516446699630:android:23540aff30c70f067ee67f',
    messagingSenderId: '516446699630',
    projectId: 'budgetapp-8c69e',
    storageBucket: 'budgetapp-8c69e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3dxRU1rHf8r7_zL2QSPBYEJauWSFMqBo',
    appId: '1:516446699630:ios:3cb4038ff97f3d7c7ee67f',
    messagingSenderId: '516446699630',
    projectId: 'budgetapp-8c69e',
    storageBucket: 'budgetapp-8c69e.appspot.com',
    iosBundleId: 'com.example.budgetTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3dxRU1rHf8r7_zL2QSPBYEJauWSFMqBo',
    appId: '1:516446699630:ios:b1d4a89a905feeb87ee67f',
    messagingSenderId: '516446699630',
    projectId: 'budgetapp-8c69e',
    storageBucket: 'budgetapp-8c69e.appspot.com',
    iosBundleId: 'com.example.budgetTracker.RunnerTests',
  );
}
