import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions]

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAfWL5YE7QHv6gBSkCvGP2caJjalTv4eRU',
    appId: '1:73710104984:web:4aec27efd0d13f4568fbed',
    messagingSenderId: '73710104984',
    projectId: 'agendamento-unhas-projeto',
    authDomain: 'agendamento-unhas-projeto.firebaseapp.com',
    storageBucket: 'agendamento-unhas-projeto.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsOXGaeJLUBl9UMXz_xXyf4udKGIaT8Cg',
    appId: '1:73710104984:android:e1321cbf604b909268fbed',
    messagingSenderId: '73710104984',
    projectId: 'agendamento-unhas-projeto',
    storageBucket: 'agendamento-unhas-projeto.firebasestorage.app',
  );
}
