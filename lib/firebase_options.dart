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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDx9JXXIY4WVHF037TnoMaIU-1iWSYIZS0',
    appId: '1:600777219577:web:abdafdfca841a048f83128',
    messagingSenderId: '600777219577',
    projectId: 'puckey-10930',
    authDomain: 'puckey-10930.firebaseapp.com',
    databaseURL: 'https://puckey-10930-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'puckey-10930.firebasestorage.app',
    measurementId: 'G-XQXP0K8P54',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3SY-WkF587l_3Ts4s7_6sU_w6edLdiZQ',
    appId: '1:600777219577:android:374f841bb9f8014cf83128',
    messagingSenderId: '600777219577',
    projectId: 'puckey-10930',
    databaseURL: 'https://puckey-10930-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'puckey-10930.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDx9JXXIY4WVHF037TnoMaIU-1iWSYIZS0',
    appId: '1:600777219577:ios:abdafdfca841a048f83128', // Placeholder for iOS App ID if not known
    messagingSenderId: '600777219577',
    projectId: 'puckey-10930',
    databaseURL: 'https://puckey-10930-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'puckey-10930.firebasestorage.app',
    iosBundleId: 'com.companyname.puckey',
  );
}
