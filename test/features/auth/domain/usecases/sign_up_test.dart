import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studioflutter/features/auth/domain/entities/user.dart';
import 'package:studioflutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:studioflutter/features/auth/domain/usecases/sign_up.dart';

import 'sign_up_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignUp usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignUp(mockRepository);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  const tUser = User(
    uid: '123',
    email: tEmail,
    displayName: null,
  );

  test('should sign up user with email and password', () async {
    // arrange
    when(mockRepository.signUpWithEmailAndPassword(any, any))
        .thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(const SignUpParams(
      email: tEmail,
      password: tPassword,
    ));

    // assert
    expect(result, const Right(tUser));
    verify(mockRepository.signUpWithEmailAndPassword(tEmail, tPassword));
    verifyNoMoreInteractions(mockRepository);
  });
}

