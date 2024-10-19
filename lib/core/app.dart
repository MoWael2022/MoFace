import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moface/core/router.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_cubit.dart';
import 'package:moface/user/presentation/controller/chat_cubit/chat_cubit.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_cubit.dart';
import 'package:moface/user/presentation/controller/loading_post_home_cubit/loading_post_home_cubit.dart';
import 'package:sizer/sizer.dart';

import '../generated/l10n.dart';
import '../user/presentation/controller/auth_cubit/auth_cubit.dart';
import '../user/presentation/controller/load_post_cubit/load_post_cubit.dart';
import '../user/presentation/controller/loading_cubit/data_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoadPostCubit()),
            BlocProvider(create: (context) => ChatCubit()),
            BlocProvider(create: (context) => GetHomePostCubit()),
            BlocProvider(create: (context) => FriendsCubit()),
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => AppCubit()),
            BlocProvider(create: (context) => DataCubit()),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
          ),
        );
      },
    );
  }
}
