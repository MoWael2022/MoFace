// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "ConfirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "CreateAnAccount":
            MessageLookupByLibrary.simpleMessage("Create an Account"),
        "Password": MessageLookupByLibrary.simpleMessage("Password"),
        "cPasswordMessageError": MessageLookupByLibrary.simpleMessage(
            "the Confirm password is required"),
        "cPasswordMessageError2":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailMessageError":
            MessageLookupByLibrary.simpleMessage("the email is required"),
        "emailMessageError2": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid email address"),
        "forgetPassword":
            MessageLookupByLibrary.simpleMessage("Forget Password?"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Already Have Account"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "passwordMessageError":
            MessageLookupByLibrary.simpleMessage("the password is required"),
        "passwordMessageError2": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 8 characters long, include an uppercase letter, a number, and a special character"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "userName": MessageLookupByLibrary.simpleMessage("Username"),
        "usernameMessageError":
            MessageLookupByLibrary.simpleMessage("the user name is required")
      };
}
