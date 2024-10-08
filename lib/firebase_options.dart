// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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
    apiKey: 'AIzaSyCaPt529K_C8NnVsiEdzdvgLIJOqsebHvU',
    appId: '1:700220519382:web:a2a285bfd8942599086a77',
    messagingSenderId: '700220519382',
    projectId: 'expense-38286',
    authDomain: 'expense-38286.firebaseapp.com',
    storageBucket: 'expense-38286.appspot.com',
    measurementId: 'G-SVL6FGP42E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOJ7dzggJ1689oxexIg6yrk0gIvn3RZQY',
    appId: '1:700220519382:android:ee98ef89fe7c02e2086a77',
    messagingSenderId: '700220519382',
    projectId: 'expense-38286',
    storageBucket: 'expense-38286.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbAa_Xl-1EALOYulSksQUHnaGEkXpJX90',
    appId: '1:700220519382:ios:c2e70581f86ea410086a77',
    messagingSenderId: '700220519382',
    projectId: 'expense-38286',
    storageBucket: 'expense-38286.appspot.com',
    iosBundleId: 'com.example.expensesTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbAa_Xl-1EALOYulSksQUHnaGEkXpJX90',
    appId: '1:700220519382:ios:c2e70581f86ea410086a77',
    messagingSenderId: '700220519382',
    projectId: 'expense-38286',
    storageBucket: 'expense-38286.appspot.com',
    iosBundleId: 'com.example.expensesTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCaPt529K_C8NnVsiEdzdvgLIJOqsebHvU',
    appId: '1:700220519382:web:b9b10598ef77fc0e086a77',
    messagingSenderId: '700220519382',
    projectId: 'expense-38286',
    authDomain: 'expense-38286.firebaseapp.com',
    storageBucket: 'expense-38286.appspot.com',
    measurementId: 'G-CTTRPR918Q',
  );

}