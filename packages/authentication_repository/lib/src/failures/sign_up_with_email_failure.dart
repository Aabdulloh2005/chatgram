class SignUpWithEmailFailure implements Exception {
  final String message;

  const SignUpWithEmailFailure(
      [this.message = "An unknown exception occurred."]);

  factory SignUpWithEmailFailure.fromCode(String code) {
    switch (code) {
      case "invalid-email":
        return const SignUpWithEmailFailure(
          "Email is not valid or badly formatted.",
        );
      case "user-disabled":
        return const SignUpWithEmailFailure(
          "This user has been disabled. Please contact support for help.",
        );
      case "email-already-in-use":
        return const SignUpWithEmailFailure(
          "An account already exists for that email.",
        );

      case "operation-not-allowed":
        return const SignUpWithEmailFailure(
          "Operation is not allowed.  Please contact support.",
        );
      case "weak-password":
        return const SignUpWithEmailFailure(
          "Please enter a stronger password.",
        );
      default:
        return const SignUpWithEmailFailure();
    }
  }
}
