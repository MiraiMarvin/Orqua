import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart' as domain;

abstract class AuthRemoteDataSource {
  Stream<domain.User?> get authStateChanges;
  Future<domain.User> signInWithEmailAndPassword(String email, String password);
  Future<domain.User> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  domain.User? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Stream<domain.User?> get authStateChanges {
    return firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser != null ? _mapFirebaseUser(firebaseUser) : null;
    });
  }

  @override
  Future<domain.User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw AuthException('Sign in failed');
      }
      return _mapFirebaseUser(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_getAuthErrorMessage(e.code));
    }
  }

  @override
  Future<domain.User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw AuthException('Sign up failed');
      }
      return _mapFirebaseUser(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_getAuthErrorMessage(e.code));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed');
    }
  }

  @override
  domain.User? getCurrentUser() {
    final firebaseUser = firebaseAuth.currentUser;
    return firebaseUser != null ? _mapFirebaseUser(firebaseUser) : null;
  }

  domain.User _mapFirebaseUser(firebase_auth.User firebaseUser) {
    return domain.User(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
    );
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Aucun utilisateur trouvé avec cet email';
      case 'wrong-password':
        return 'Mot de passe incorrect';
      case 'email-already-in-use':
        return 'Cet email est déjà utilisé';
      case 'invalid-email':
        return 'Email invalide';
      case 'weak-password':
        return 'Mot de passe trop faible';
      default:
        return 'Une erreur est survenue';
    }
  }
}

