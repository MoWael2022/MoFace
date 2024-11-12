// // mobile_cookie_manager.dart
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:path_provider/path_provider.dart';
// import "package:path/path.dart" as p;
//
// Future<CookieJar> getCookieJar() async {
//   final appDocDir = await getApplicationDocumentsDirectory();
//   final cookieDir = p.join(appDocDir.path, "cookies");
//   return PersistCookieJar(storage: FileStorage(cookieDir));
// }
