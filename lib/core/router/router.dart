import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/core/user_data/user_data_provider.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/base_auth_cubit.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/login_cubit.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/register_cubit.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/screens/authentication_screen.dart';
import 'package:mo_face_app/feature/splash/controller/data_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_friend_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_suggestion_friend_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/manage_friend_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/screens/user_profile.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/presentation/controller/comment_cubit.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/get_home_post_cubit.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/get_profile_post_cubit.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/manage_profile_post.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/presentation/controller/react_cubit.dart';
import 'package:mo_face_app/feature/user/profile/presentation/screens/profile_screen.dart';

import '../../feature/payment/presentation/controller/paymnet_cubit.dart';
import '../../feature/splash/screen/splash_screen.dart';
import '../../feature/user/friends_feature/presentation/screens/suggestion_friend.dart';
import '../../feature/user/home/presentation/screens/home_screen.dart';
import '../service_locator/service_locator.dart';

class Routers {
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String userprofile = '/userProfile';
  static const String suggestionFriends = '/suggestion';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    final user = UserDataProvider().userData;
    switch (routeSettings.name) {
      case Routers.splashScreen:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => instance<DataCubit>(),
            child: const SplashScreen(),
          );
        });

      case Routers.login:
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => instance<LoginCubit>()),
              BlocProvider(create: (context) => instance<RegisterCubit>()),
            ],
            child: const LoginScreen(),
          );
        });
      case Routers.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => instance<CommentCubit>()),
              BlocProvider(create: (context) => instance<GetHomePostCubit>()),
              BlocProvider(create: (context) => instance<ReactCubit>()),
              BlocProvider(create: (context) => instance<ManageProfilePost>()),
              BlocProvider(create: (context) => instance<GetMyFriendCubit>()),
              BlocProvider(create: (context) => instance<GetSuggestionFriendCubit>()),
              //BlocProvider(create: (context) => instance<PaymentCubit>()),
              //BlocProvider(create: (context) => instance<GetProfilePostCubit>()),
              //BlocProvider(create: (context) => instance<LoginCubit>()),
            ],
            child: const HomeScreen(),
          ),
        );
      case Routers.profile:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => instance<GetProfilePostCubit>()),
              BlocProvider(create: (context) => instance<CommentCubit>()),
              BlocProvider(create: (context) => instance<ReactCubit>()),
              BlocProvider(create: (context) => instance<ManageProfilePost>()),
            ],
            child: ProfileScreen(),
          ),
        );
      case Routers.suggestionFriends:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => instance<GetSuggestionFriendCubit>()),
                    BlocProvider(create: (context) => instance<ManageFriendCubit>()),
                  ],
                  child: const SuggestionFriendsScreen(),
                ));
      // case Routers.userprofile:
      //   return MaterialPageRoute(
      //       builder: (context) => MultiBlocProvider(
      //         providers: [
      //           BlocProvider(
      //               create: (context) => instance<GetProfilePostCubit>()),
      //           BlocProvider(create: (context) => instance<CommentCubit>()),
      //           BlocProvider(create: (context) => instance<ReactCubit>()),
      //           BlocProvider(create: (context) => instance<ManageProfilePost>()),
      //         ],
      //         child: const UserProfileScreen(),
      //       ));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: const Center(
                child: Text("No Route Found"),
              ),
            ));
  }
}
