String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter your email address';
  } else if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value)) {
    return 'please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter your password';
  } else if (value.length < 8) {
    return 'password must be 8 characters';
  } else if (!value.contains("@")) {
    return "password must have the '@' symbol";
  }
  return null;
}

String? validDate(String? input) {
  // Split the input string by '-' to extract year, month, and day
  List<String> parts = input!.split('-');

  // Check if there are exactly three parts (year, month, day)
  if (parts.length != 3) {
    return null;
  }

  // Parse each part into integers
  int? day = int.tryParse(parts[2]);
  int? month = int.tryParse(parts[1]);
  int? year = int.tryParse(parts[0]);

  // Check if year, month, and day are valid
  if (day == null || month == null || year == null) {
    return "Please make sure to enter the date properly";
  }

  // Check if month is between 1 and 12
  if (month < 1 || month > 12) {
    return "Select a month between 1 to 12";
  }

  // Check if day is valid for the given month and year
  if (day < 1 || day > DateTime(year, month + 1, 0).day) {
    return "Enter the correct date";
  }

  // If all checks pass, return true
  return null;
}

String? validateCap(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill in this part";
  }
  return null;
}

String? validateNum(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill in this part";
  } else if (value.length == 10) {
    return null;
  }
  return null;
}

String? validateId(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill in this part";
  } else if (value.length == 13) {
    return null;
  }
  return null;
}
