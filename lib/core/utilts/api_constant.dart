import 'package:flutter/material.dart';

class Constant {
  static const String webSocketUrl = "wss://facemo.azurewebsites.net/chathub";
  static const String baseUrl = "https://facemo.azurewebsites.net";
  static const String register = "$baseUrl/Authentication/register";
  static const String decryptToken = "$baseUrl/Authentication/DecryptJWT";
  static const String login = "$baseUrl/Authentication/login";
  static const String refreshToken = "$baseUrl/Authentication/refreshToken";
  static const String ensureTokenValidation = "$baseUrl/api/can_be_ok/OK";
  static const String logout = "$baseUrl/Authentication/logout";
  static const String addPost = "$baseUrl/V1/Post";
  static const String deletePost = "$baseUrl/V1/Post";
  static const String addComment = "$baseUrl/V1/Comment";
  static const String deleteComment = "$baseUrl/V1/Comment";
  static const String react = "$baseUrl/React";
  static const String sendRequest = "$baseUrl/V1/Friend/RequestSend";
  static const String acceptRequest = "$baseUrl/V1/Friend/RequestAccept";
  static const String cancelRequest = "$baseUrl/V1/Friend/Request";

  static String getMyFriends(String userId) => '$baseUrl/V1/Friend/$userId';

  static String getMySuggestionFriends(String userId) =>
      '$baseUrl/V1/Friend/Suggestions/$userId';

  static String getMyRequestSend(String userId) =>
      '$baseUrl/V1/Friend/RequestSend/$userId';

  static String getMyRequestReceive(String userId) =>
      '$baseUrl/V1/Friend/RequestReceive/$userId';

  static String viewAllUserPost(String userId) =>
      "$baseUrl/V1/Post/userid/$userId";

  static String viewAllUserPostFriends(String userId) =>
      "$baseUrl/V1/Post/MeWithFriend/$userId";

  static String updateComment(int commentId) =>
      "$baseUrl/V1/Comment/$commentId";

  static String getPost(int postId, String userId) =>
      "$baseUrl/V1/post/$postId/$userId";

  static String updatePost(int postId) => "$baseUrl/V1/post/$postId";

  static String changeProfileImage(String userId) =>
      "$baseUrl/profilepicture/$userId";

  static String changeBackgroundImage(String userId) =>
      "$baseUrl/backgroundimg/$userId";

  static String getChatBetweenUser(String senderId, String receiverId) =>
      "$baseUrl/V1/Chat/ourmessage/?idreciv=$receiverId&idsend=$senderId";

  static String sendOfflineMessage(
      String senderId, String receiverId, String message) =>
      "$baseUrl/V1/Chat?idreciv=$receiverId&idsend=$senderId&messge=$message";

  static double height(context) => MediaQuery.of(context).size.height;

  static double width(context) => MediaQuery.of(context).size.width;

  //payment
  static const String apiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1Rrd05EQXhMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuQUhHZndTTWFDcWhxbGVTUUcyc2FOLVBONGk2emJBNjJwNTlTTU5RU3F3bGJSaTdtbExpLUd3empRSk81ZDRlMXVKbXVnbWxpcmpYd3JHRnNYNUFLRVE=";
  static const String basePaymentUrl = "https://accept.paymob.com/api";
  static const String authenticationToken = "$basePaymentUrl/auth/tokens";
  static const String paymentId = "$basePaymentUrl/ecommerce/orders";
  static const String paymentToken = "$basePaymentUrl/acceptance/payment_keys";
  static const String onlineCardPaymentIntegrationId = "4629961";
  static const String kioskPaymentIntegrationId = "4862680";

  static String iframePayment(token) =>
      "https://accept.paymob.com/api/acceptance/iframes/861847?payment_token=$token";
}
