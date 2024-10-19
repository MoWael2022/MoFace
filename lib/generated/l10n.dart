// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get ConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'ConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create an Account`
  String get CreateAnAccount {
    return Intl.message(
      'Create an Account',
      name: 'CreateAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already Have Account`
  String get haveAccount {
    return Intl.message(
      'Already Have Account',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `the email is required`
  String get emailMessageError {
    return Intl.message(
      'the email is required',
      name: 'emailMessageError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get emailMessageError2 {
    return Intl.message(
      'Please enter a valid email address',
      name: 'emailMessageError2',
      desc: '',
      args: [],
    );
  }

  /// `the password is required`
  String get passwordMessageError {
    return Intl.message(
      'the password is required',
      name: 'passwordMessageError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long, include an uppercase letter, a number, and a special character`
  String get passwordMessageError2 {
    return Intl.message(
      'Password must be at least 8 characters long, include an uppercase letter, a number, and a special character',
      name: 'passwordMessageError2',
      desc: '',
      args: [],
    );
  }

  /// `the Confirm password is required`
  String get cPasswordMessageError {
    return Intl.message(
      'the Confirm password is required',
      name: 'cPasswordMessageError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get cPasswordMessageError2 {
    return Intl.message(
      'Passwords do not match',
      name: 'cPasswordMessageError2',
      desc: '',
      args: [],
    );
  }

  /// `the user name is required`
  String get usernameMessageError {
    return Intl.message(
      'the user name is required',
      name: 'usernameMessageError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
