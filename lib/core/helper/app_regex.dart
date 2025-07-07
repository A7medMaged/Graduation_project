class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    if (password.length < 8) return false;

    if (!RegExp(r'[a-z]').hasMatch(password)) return false;

    if (!RegExp(r'[A-Z]').hasMatch(password)) return false;

    if (!RegExp(r'\d').hasMatch(password)) return false;

    if (!RegExp(r'[!@#$%^&*()_+\-=\[\]{}|;:",./<>?~`]').hasMatch(password)) {
      return false;
    }

    return true;
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }
}
