import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthProvider with ChangeNotifier {
  final SignIn signIn;
  final SignUp signUp;
  final SignOut signOut;
  final AuthRepository repository;

  AuthProvider({
    required this.signIn,
    required this.signUp,
    required this.signOut,
    required this.repository,
  }) {
    repository.authStateChanges.listen((user) {
      _currentUser = user;
      _state = user != null ? AuthState.authenticated : AuthState.unauthenticated;
      notifyListeners();
    });
  }

  AuthState _state = AuthState.initial;
  User? _currentUser;
  String _errorMessage = '';

  AuthState get state => _state;
  User? get currentUser => _currentUser;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _state = AuthState.loading;
    _errorMessage = '';
    notifyListeners();

    final result = await signIn(SignInParams(email: email, password: password));
    result.fold(
      (failure) {
        _state = AuthState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (user) {
        _state = AuthState.authenticated;
        _currentUser = user;
        notifyListeners();
      },
    );
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    _state = AuthState.loading;
    _errorMessage = '';
    notifyListeners();

    final result = await signUp(SignUpParams(email: email, password: password));
    result.fold(
      (failure) {
        _state = AuthState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (user) {
        _state = AuthState.authenticated;
        _currentUser = user;
        notifyListeners();
      },
    );
  }

  Future<void> signOutUser() async {
    final result = await signOut(NoParams());
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (_) {
        _state = AuthState.unauthenticated;
        _currentUser = null;
        notifyListeners();
      },
    );
  }
}

