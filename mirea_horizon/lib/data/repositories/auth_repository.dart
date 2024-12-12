import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> authStateChanges() {
    print('AuthRepository: Starting to listen to auth state changes');
    return _firebaseAuth.authStateChanges().asBroadcastStream()
      ..listen(
        (user) => print('AuthRepository: Auth state changed - User: ${user?.email ?? 'None'}'),
        onError: (error) => print('AuthRepository: Error in auth state stream: $error'),
      );
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      print('AuthRepository: Attempting to sign up user: $email');
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('AuthRepository: Sign up successful for user: ${credential.user?.email}');
      return credential;
    } on FirebaseAuthException catch (e) {
      print('AuthRepository: FirebaseAuthException during sign up:');
      print('Error code: ${e.code}');
      print('Error message: ${e.message}');
      
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
      throw Exception(e.message);
    } catch (e) {
      print('AuthRepository: General exception during sign up: $e');
      throw Exception(e.toString());
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      print('AuthRepository: Attempting to sign in user: $email');
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('AuthRepository: Sign in successful for user: ${credential.user?.email}');
      return credential;
    } on FirebaseAuthException catch (e) {
      print('AuthRepository: FirebaseAuthException during sign in:');
      print('Error code: ${e.code}');
      print('Error message: ${e.message}');
      
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
      throw Exception(e.message);
    } catch (e) {
      print('AuthRepository: General exception during sign in: $e');
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      print('AuthRepository: Attempting to sign out');
      await _firebaseAuth.signOut();
      print('AuthRepository: Sign out successful');
    } catch (e) {
      print('AuthRepository: Error during sign out: $e');
      throw Exception(e.toString());
    }
  }
}
