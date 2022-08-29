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
    apiKey: 'AIzaSyBQHC3BV9XHXXTtBRXJdQyP0Ubxo9DCi6I',
    appId: '1:1072576326962:web:70d8f720a42b0e852cfb2b',
    messagingSenderId: '1072576326962',
    projectId: 'biteshaq',
    authDomain: 'biteshaq.firebaseapp.com',
    storageBucket: 'biteshaq.appspot.com',
    measurementId: 'G-81JRJ8PKG7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGT-sZHfHfAsgsv2pvguYm2puCsWXiO2o',
    appId: '1:1072576326962:android:6bd0426ff80d21b32cfb2b',
    messagingSenderId: '1072576326962',
    projectId: 'biteshaq',
    storageBucket: 'biteshaq.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARX1ynG1WDaNDBQMbmja3gsqnBdK_r5ag',
    appId: '1:1072576326962:ios:0d0c47a11136094d2cfb2b',
    messagingSenderId: '1072576326962',
    projectId: 'biteshaq',
    storageBucket: 'biteshaq.appspot.com',
    iosClientId:
        '1072576326962-n0srf7f67kdq0p588uf7fhq8pfpddebm.apps.googleusercontent.com',
    iosBundleId: 'com.r2am9d.apps.biteshaq',
  );
}
