import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

String? validateEmail(String? email) {
  RegExp emailRegex = RegExp(r'^[\w`]+@[\w~]+\.\w{2,3}(\.\w{2,3})?$');
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
  final nameReg = RegExp(r'([A-Za-z]+)');
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

final today = DateTime.now();

// the date 18 years ago
final initialDate = DateTime.now().subtract(const Duration(days: 365 * 18));

// the first day
final firstDate = DateTime(1900);

// the last possible date, the user should at least be 7 years old
final lastDate = DateTime.now().subtract(const Duration(days: 365 * 7));

Future<Future<DateTime?>> pickSimpleDate({
  required BuildContext context,
  required DateTime? date,
}) async {
  final dateTime = DatePicker.showSimpleDatePicker(
    context,
    initialDate: date ?? initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    dateFormat: "dd-MMMM-yyyy",
  );

  return dateTime;
}

void showToastMessage({
  required String e
}) async {
  Fluttertoast.showToast(
    msg: e,
    backgroundColor: Colors.black54,
    fontSize: 18,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM
  );
}

