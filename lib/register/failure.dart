
class SignUpWithEmailAndPassFailure {
  final String message;

  const SignUpWithEmailAndPassFailure([this.message = "An Unknown error occured"]);

  factory SignUpWithEmailAndPassFailure.code(String code){
    switch(code) {
      case 'weak-password' :
        return const SignUpWithEmailAndPassFailure("please enter a stronger password");
      case 'invalid-email' :
        return const SignUpWithEmailAndPassFailure("Email is not valid");
      case 'email-already-in-use' :
        return const SignUpWithEmailAndPassFailure("An Account already exists");
      case 'operation-not-allowed' :
        return const SignUpWithEmailAndPassFailure("Operation is not allowed.");
      case 'user-disabled' :
        return const SignUpWithEmailAndPassFailure("This user is disabled.");
      default:
        return const SignUpWithEmailAndPassFailure();
    }
  }
}