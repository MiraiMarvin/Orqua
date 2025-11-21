import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studioflutter/core/usecases/usecase.dart';
import 'package:studioflutter/features/auth/domain/entities/user.dart';
import 'package:studioflutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:studioflutter/features/auth/domain/usecases/sign_in.dart';

import 'sign_in_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignIn usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignIn(mockRepository);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  const tUser = User(
    uid: '123',
    email: tEmail,
    displayName: 'Test User',
  );

  test('should sign in user with email and password', () async {
    // arrange
    when(mockRepository.signInWithEmailAndPassword(any, any))
        .thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(const SignInParams(
      email: tEmail,
      password: tPassword,
    ));

    // assert
    expect(result, const Right(tUser));
    verify(mockRepository.signInWithEmailAndPassword(tEmail, tPassword));
    verifyNoMoreInteractions(mockRepository);
  });
}

