// TODO: Remplacer ces credentials par vos propres credentials Firebase
// Voir FIREBASE_SETUP.md pour les instructions détaillées

class FirebaseConfig {
  static const String apiKey = 'YOUR_API_KEY';
  static const String appId = 'YOUR_APP_ID';
  static const String messagingSenderId = 'YOUR_SENDER_ID';
  static const String projectId = 'YOUR_PROJECT_ID';

  // Pour Web uniquement
  static const String authDomain = 'YOUR_PROJECT_ID.firebaseapp.com';
  static const String storageBucket = 'YOUR_PROJECT_ID.appspot.com';
  static const String measurementId = 'G-XXXXXXXXXX';
}

/*
INSTRUCTIONS RAPIDES:

1. Allez sur https://console.firebase.google.com
2. Créez un projet ou utilisez un existant
3. Activez Authentication > Email/Password
4. Dans Project Settings, ajoutez votre app (Web/Android/iOS)
5. Copiez les valeurs ci-dessus
6. Mettez à jour ce fichier
7. Utilisez FirebaseConfig dans main.dart

Exemple d'utilisation dans main.dart:

await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: FirebaseConfig.apiKey,
    appId: FirebaseConfig.appId,
    messagingSenderId: FirebaseConfig.messagingSenderId,
    projectId: FirebaseConfig.projectId,
  ),
);
*/

