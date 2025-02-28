// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDneSTt7_P_xyhevUdh4K1QOrATPSo2Rgo',
    appId: '1:559210780899:web:4238b0e7fb5bc531d1cdd6',
    messagingSenderId: '559210780899',
    projectId: 'note-todo-app-b7080',
    authDomain: 'note-todo-app-b7080.firebaseapp.com',
    storageBucket: 'note-todo-app-b7080.firebasestorage.app',
    measurementId: 'G-XVBT76GJ41',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCh1S3FFdpClDeaIHgrqPgXjeWbjINe-GA',
    appId: '1:559210780899:android:9a24c52438bb55c9d1cdd6',
    messagingSenderId: '559210780899',
    projectId: 'note-todo-app-b7080',
    storageBucket: 'note-todo-app-b7080.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_x02fxr37f-Gti-4rsGXI6TLVs9ZBmSo',
    appId: '1:559210780899:ios:f83c613dee2316f0d1cdd6',
    messagingSenderId: '559210780899',
    projectId: 'note-todo-app-b7080',
    storageBucket: 'note-todo-app-b7080.firebasestorage.app',
    iosBundleId: 'com.notes.todo',
  );
}
