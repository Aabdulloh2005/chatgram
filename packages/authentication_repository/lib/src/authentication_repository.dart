import 'package:authentication_repository/src/failures/failures.dart';
import 'package:authentication_repository/src/models/user.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class AuthenticationRepository {
  final CacheClient _cache;

  final f_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository(
      {CacheClient? cache,
      f_auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn})
      : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? f_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  @visibleForTesting
  bool isWeb = kIsWeb;

  @visibleForTesting
  static const userCacheKey = "__user_cache_key__";

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map(
      (firebaseUser) {
        final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
        _cache.write(key: userCacheKey, value: user);
        return user;
      },
    );
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<f_auth.User?> signUp(
      {required String email, required String password}) async {
    try {
      final userInfo = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userInfo.user;
    } on f_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailFailure.fromCode(e.code);
    } catch (e) {
      throw const SignUpWithEmailFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      late final f_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = f_auth.GoogleAuthProvider();
        final userCredential =
            await _firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = f_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on f_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailFailure.fromCode(e.code);
    } catch (e) {
      throw LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on f_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailFailure.fromCode(e.code);
    } catch (e) {
      throw LogInWithEmailFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait(
        [
          _firebaseAuth.signOut(),
          _googleSignIn.signOut(),
        ],
      );
    } catch (e) {
      throw LogOutFailure();
    }
  }
}

extension on f_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
