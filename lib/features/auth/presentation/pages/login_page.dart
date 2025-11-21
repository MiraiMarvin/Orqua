import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studioflutter/core/theme/orqua_theme.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    if (_isSignUp) {
      await authProvider.signUpWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } else {
      await authProvider.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }

    if (mounted && authProvider.state == AuthState.authenticated) {
      context.go('/catalog');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrquaTheme.sand,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 4,
                      color: OrquaTheme.primaryBlue,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'ORQUA',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: OrquaTheme.primaryBlue,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 8,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'PRODUITS FRAIS DE LA MER',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: OrquaTheme.darkGrey,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: 80,
                      height: 4,
                      color: OrquaTheme.accentCoral,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: OrquaTheme.primaryBlue, width: 2),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _isSignUp ? 'CRÉER UN COMPTE' : 'CONNEXION',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: OrquaTheme.darkGrey,
                              letterSpacing: 2,
                            ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 12, letterSpacing: 1),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre email';
                          }
                          if (!value.contains('@')) {
                            return 'Email invalide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(fontSize: 12, letterSpacing: 1),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre mot de passe';
                          }
                          if (value.length < 6) {
                            return 'Minimum 6 caractères';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, _) {
                          if (authProvider.state == AuthState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: OrquaTheme.primaryBlue,
                              ),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: _submit,
                                child: Text(
                                  _isSignUp ? 'S\'INSCRIRE' : 'SE CONNECTER',
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isSignUp = !_isSignUp;
                                  });
                                },
                                child: Text(
                                  _isSignUp
                                      ? 'Déjà un compte ? Se connecter'
                                      : 'Pas de compte ? S\'inscrire',
                                  style: const TextStyle(
                                    color: OrquaTheme.primaryBlue,
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              if (authProvider.errorMessage.isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFEBEE),
                                    border: Border(
                                      left: BorderSide(
                                        color: Color(0xFFD32F2F),
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    authProvider.errorMessage,
                                    style: const TextStyle(
                                      color: Color(0xFFD32F2F),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

