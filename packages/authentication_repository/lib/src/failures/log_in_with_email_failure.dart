class LogInWithEmailFailure implements Exception {
  String message;

  LogInWithEmailFailure([this.message = "An unknown exception occurred."]);

  factory LogInWithEmailFailure.fromCode(String code) {
    switch (code) {
      case "invalid-email":
        return LogInWithEmailFailure(
          "Email is not valid or badly formatted.",
        );
      case "user-disabled":
        return LogInWithEmailFailure(
          "This user has been disabled. Please contact support for help.",
        );
      case "user-not-found":
        return LogInWithEmailFailure(
          "Email is not found, please create an account.",
        );
      case "wrong-password":
        return LogInWithEmailFailure(
          "Incorrect password, please try again.",
        );
      default:
        return LogInWithEmailFailure();
    }
  }
}
