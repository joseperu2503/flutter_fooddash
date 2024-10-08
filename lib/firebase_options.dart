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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-3aMP0N4vybC-lIlUOXTDhaR71TkOnrs',
    appId: '1:876422063505:android:da10f1b1c75b80a4cca630',
    messagingSenderId: '876422063505',
    projectId: 'fooddash-6dc1f',
    storageBucket: 'fooddash-6dc1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4Nkree5_2XLXjI9IUbgsfSS7Nx_b96_I',
    appId: '1:876422063505:ios:687c745c6d0ff100cca630',
    messagingSenderId: '876422063505',
    projectId: 'fooddash-6dc1f',
    storageBucket: 'fooddash-6dc1f.appspot.com',
    androidClientId: '876422063505-1vvrcecfabr7dh0a3bqqaani8s277h8u.apps.googleusercontent.com',
    iosClientId: '876422063505-qkcd7munu7s3hh5ojfkecionm4jpuqcg.apps.googleusercontent.com',
    iosBundleId: 'com.joseperezgil.foodash',
  );
}
