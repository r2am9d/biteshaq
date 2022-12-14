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
    apiKey: 'AIzaSyDqS_uKPsStm12tAzEK8IV1L5M63EpfVQY',
    appId: '1:683488262101:web:1eb41ffaff60aa70a22f5c',
    messagingSenderId: '683488262101',
    projectId: 'biteshaq-dev',
    authDomain: 'biteshaq-dev.firebaseapp.com',
    storageBucket: 'biteshaq-dev.appspot.com',
    measurementId: 'G-4QNM5BJ27P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_vit-OOzeT9TFaEkZrR8hLvDsjjBKRDk',
    appId: '1:683488262101:android:ab0cadff66556e7ea22f5c',
    messagingSenderId: '683488262101',
    projectId: 'biteshaq-dev',
    storageBucket: 'biteshaq-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgzsqZbLVd6E7ursBUemGfExI3bXMyMD0',
    appId: '1:683488262101:ios:21839e9a4c9824a4a22f5c',
    messagingSenderId: '683488262101',
    projectId: 'biteshaq-dev',
    storageBucket: 'biteshaq-dev.appspot.com',
    iosClientId:
        '683488262101-epjhh7tiu3neq91dfnedojdgbuhfogff.apps.googleusercontent.com',
    iosBundleId: 'com.r2am9d.apps.biteshaq.dev',
  );
}
