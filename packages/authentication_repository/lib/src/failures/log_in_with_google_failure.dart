class LogInWithGoogleFailure implements Exception {
  String message;

  LogInWithGoogleFailure([
    this.message = "An unknown exception occurred.",
  ]);

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case "account-exists-with-different-credential":
        return LogInWithGoogleFailure(
          "Account exists with different credentials.",
        );
      case "invalid-credential":
        return LogInWithGoogleFailure(
          "The credential received is malformed or has expired.",
        );
      case "operation-not-allowed":
        return LogInWithGoogleFailure(
          "Operation is not allowed.  Please contact support.",
        );
      case "user-disabled":
        return LogInWithGoogleFailure(
          "This user has been disabled. Please contact support for help.",
        );
      case "user-not-found":
        return LogInWithGoogleFailure(
          "Email is not found, please create an account.",
        );
      case "wrong-password":
        return LogInWithGoogleFailure(
          "Incorrect password, please try again.",
        );
      case "invalid-verification-code":
        return LogInWithGoogleFailure(
          "The credential verification code received is invalid.",
        );
      case "invalid-verification-id":
        return LogInWithGoogleFailure(
          "The credential verification ID received is invalid.",
        );
      default:
        return LogInWithGoogleFailure();
    }
  }
}
