class Utils {
  bool validateEmail(String email) {
    RegExp exp = RegExp(
        r"^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$");
    return exp.hasMatch(email.toLowerCase());
  }
}
