String? validateEmail(String? email) {
  RegExp emailRegex = RegExp(r'^[\w\.`]+@[\w~]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email ?? '');
  if (!isEmailValid) {
    return "Please enter a valid email";
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null) {
    return "Please enter a valid password";
  } else if (password.length < 6) {
    return "Your password should be at least 6 characters";
  }

  return null;
}

String? validateName(String? name) {
  final nameReg = RegExp(r'[a-zA-Z\s]{1, 50}$');
  if (name == null) {
    return "The name cannot be null";
  } else if (name.isEmpty) {
    return "Name should be at least 6 charaters";
  } else if (!nameReg.hasMatch(name)) {
    return "Please enter a valid name";
  } else {
    return null;
  }
}