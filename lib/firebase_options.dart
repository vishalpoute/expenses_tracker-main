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
    apiKey: 'AIzaSyBc-qXyNWhdH6FFOljWcFEJQF5ePrqXYBs',
    appId: '1:1050142179040:web:3d29f507696fa535e55a85',
    messagingSenderId: '1050142179040',
    projectId: 'finance-manager-a7c52',
    authDomain: 'finance-manager-a7c52.firebaseapp.com',
    storageBucket: 'finance-manager-a7c52.appspot.com',
    measurementId: 'G-3L8D0P7FB1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCa-qt3IHazTFTbVXOGv6pcgjW1jBjIdXI',
    appId: '1:1050142179040:android:fbc2fe9aa1ec54ebe55a85',
    messagingSenderId: '1050142179040',
    projectId: 'finance-manager-a7c52',
    storageBucket: 'finance-manager-a7c52.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJEI0RrfTNh6o27bGDc1_YuHbAQIrPXQY',
    appId: '1:1050142179040:ios:401cca585b3ca587e55a85',
    messagingSenderId: '1050142179040',
    projectId: 'finance-manager-a7c52',
    storageBucket: 'finance-manager-a7c52.appspot.com',
    iosBundleId: 'com.example.expensesTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDJEI0RrfTNh6o27bGDc1_YuHbAQIrPXQY',
    appId: '1:1050142179040:ios:401cca585b3ca587e55a85',
    messagingSenderId: '1050142179040',
    projectId: 'finance-manager-a7c52',
    storageBucket: 'finance-manager-a7c52.appspot.com',
    iosBundleId: 'com.example.expensesTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBc-qXyNWhdH6FFOljWcFEJQF5ePrqXYBs',
    appId: '1:1050142179040:web:a69287250be91daae55a85',
    messagingSenderId: '1050142179040',
    projectId: 'finance-manager-a7c52',
    authDomain: 'finance-manager-a7c52.firebaseapp.com',
    storageBucket: 'finance-manager-a7c52.appspot.com',
    measurementId: 'G-HGMEHLVYJ1',
  );

}