// ignore_for_file: unnecessary_string_escapes

class TextfieldValidator {
  static final RegExp emailRegex = RegExp(
    "^[a-zA-Z0-9._%+-]{3,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$",
  );
  static final RegExp phoneRegex = RegExp("^[9876][0-9]{9}\$");
  static final RegExp urlRegex = RegExp(
    "^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})(:\d+)?(\/[^\s]*)?\$",
  );

  static String? validateEmail({String? email}) {
    if (email == null || email.isEmpty) {
      return "Please enter email";
    } else if (emailRegex.hasMatch(email)) {
      return null;
    } else {
      return "Enter valid Email";
    }
  }

  static String? validatePhone({String? phone}) {
    if (phone == null || phone.isEmpty) {
      return "Please enter phone number";
    } else if (phoneRegex.hasMatch(phone)) {
      return null;
    } else {
      return "Enter valid phone number";
    }
  }

  static String? validateUrl({String? url}) {
    if (url == null || url.isEmpty) {
      return "Please enter url link";
    } else if (urlRegex.hasMatch(url)) {
      return null;
    } else {
      return "Enter valid url ex:https://hub.com/";
    }
  }

  static String? validateText({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field can't be mepty";
    } else {
      return null;
    }
  }
}
