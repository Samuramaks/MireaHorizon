abstract class AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  SignUpRequested(this.email, this.password, this.displayName);
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}

class SignInAsGuest extends AuthEvent {}
