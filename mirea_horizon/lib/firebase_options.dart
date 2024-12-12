// import 'package:firebase_core/firebase_core.dart';
// import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMS4W3WcdpAE8_ncuyFhDtrMG-Xp3uTd4',
    appId: '1:91590485525:ios:d64291d0280b937f2c501c',
    messagingSenderId: '91590485525',
    projectId: 'mireahorizon',
    storageBucket: 'mireahorizon.firebasestorage.app',
    iosClientId:
        '91590485525-3vbr0vvqcg6oa8iqd1p1ij0ij1v3rnmv.apps.googleusercontent.com',
    iosBundleId: 'com.example.mireaHorizon',
  );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDahNqTE_ByTaIrKxeE_k8QW3tEh6CeYKI',
    appId: '1:91590485525:android:a9fc38ad6ecc1b042c501c',
    messagingSenderId: '91590485525',
    projectId: 'mireahorizon',
    storageBucket: 'mireahorizon.firebasestorage.app',
  );
}
