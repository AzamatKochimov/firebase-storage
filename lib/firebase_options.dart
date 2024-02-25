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
    apiKey: 'AIzaSyAoBu5wwhYIhX-Ieav_JwRDbv8s4Ndn_7Y',
    appId: '1:653827670146:web:14462987dc9795a8abb49b',
    messagingSenderId: '653827670146',
    projectId: 'realtimedisplay-8ddff',
    authDomain: 'realtimedisplay-8ddff.firebaseapp.com',
    storageBucket: 'realtimedisplay-8ddff.appspot.com',
    measurementId: 'G-904WHYSV68',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPP8IQvKmIfGSqlrTI3uaVPXfcdAOMCLo',
    appId: '1:653827670146:android:93daf872ab50997dabb49b',
    messagingSenderId: '653827670146',
    projectId: 'realtimedisplay-8ddff',
    storageBucket: 'realtimedisplay-8ddff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvHLQLi8TSWVUsVpAsvqrIpTlY7033SUc',
    appId: '1:653827670146:ios:31c20e181870f8f3abb49b',
    messagingSenderId: '653827670146',
    projectId: 'realtimedisplay-8ddff',
    storageBucket: 'realtimedisplay-8ddff.appspot.com',
    iosBundleId: 'com.example.realTimeFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvHLQLi8TSWVUsVpAsvqrIpTlY7033SUc',
    appId: '1:653827670146:ios:9739393c899c9ddbabb49b',
    messagingSenderId: '653827670146',
    projectId: 'realtimedisplay-8ddff',
    storageBucket: 'realtimedisplay-8ddff.appspot.com',
    iosBundleId: 'com.example.realTimeFirebase.RunnerTests',
  );
}