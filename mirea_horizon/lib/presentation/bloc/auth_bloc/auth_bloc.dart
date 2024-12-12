import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription<User?> _authStateSubscription;

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // Инициализируем подписку на изменения состояния аутентификации
    _authStateSubscription = authRepository.authStateChanges().listen(
      (User? user) {
        print('Auth state changed: ${user?.email ?? 'No user'}');
        if (user != null) {
          print('Emitting Authenticated state for user: ${user.email}');
          emit(Authenticated(user));
        } else {
          print('Emitting UnAuthenticated state');
          emit(UnAuthenticated());
        }
      },
      onError: (error) {
        print('Error in auth state stream: $error');
        emit(AuthError(error.toString()));
      },
    );

    on<SignInRequested>((event, emit) async {
      print('Processing SignInRequested event');
      emit(Loading());
      
      try {
        print('Attempting to sign in with email: ${event.email}');
        final credential = await authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        print('Sign in successful for user: ${credential.user?.email}');
        // Состояние будет обновлено через stream listener
      } catch (e) {
        print('Error during sign in: $e');
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      print('Processing SignUpRequested event');
      emit(Loading());
      
      try {
        print('Attempting to sign up with email: ${event.email}');
        final credential = await authRepository.signUp(
          email: event.email,
          password: event.password,
        );
        print('Sign up successful for user: ${credential.user?.email}');
        // Состояние будет обновлено через stream listener
      } catch (e) {
        print('Error during sign up: $e');
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      print('Processing SignOutRequested event');
      emit(Loading());
      
      try {
        await authRepository.signOut();
        print('Sign out successful');
        // Состояние будет обновлено через stream listener
      } catch (e) {
        print('Error during sign out: $e');
        emit(AuthError(e.toString()));
      }
    });
  }

  @override
  Future<void> close() async {
    await _authStateSubscription.cancel();
    return super.close();
  }
}
