// import 'package:cookie_jar/cookie_jar.dart';
//
// class WebCookieJar extends CookieJar {
//   @override
//   Future<List<Cookie>> loadForRequest(Uri uri) async {
//     final cookies = <Cookie>[];
//     final cookieString = html.document.cookie;
//
//     if (cookieString != null && cookieString.isNotEmpty) {
//       final cookieList = cookieString.split('; ');
//       for (var cookie in cookieList) {
//         final cookieParts = cookie.split('=');
//         if (cookieParts.length == 2) {
//           cookies.add(Cookie(cookieParts[0], cookieParts[1]));
//         }
//       }
//     }
//
//     return cookies;
//   }
//
//   @override
//   Future<void> saveFromResponse(Uri uri, List<Cookie> cookies) async {
//     for (var cookie in cookies) {
//       String cookieString =
//           '${cookie.name}=${cookie.value}; path=/; SameSite=Lax';
//       if (cookie.expires != null) {
//         cookieString += '; expires=${cookie.expires!.toUtc().toIso8601String()}';
//       }
//       html.document.cookie = cookieString;
//     }
//   }
//
//   @override
//   Future<void> delete(Uri uri, [bool withDomainSharedCookie = false]) {
//     // TODO: implement delete
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> deleteAll() {
//     // TODO: implement deleteAll
//     throw UnimplementedError();
//   }
// }
