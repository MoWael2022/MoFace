import 'package:get_it/get_it.dart';
import 'package:moface/user/data/datasource/base_remote_user_datasource.dart';
import 'package:moface/user/data/repository/user_repository.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/close_connection_usecase.dart';
import 'package:moface/user/domin/usecase/connect_to_web_socket_use_case.dart';
import 'package:moface/user/domin/usecase/delete_post_usecase.dart';
import 'package:moface/user/domin/usecase/ensure_token_validation_usecase.dart';
import 'package:moface/user/domin/usecase/friends_data_usecase.dart';
import 'package:moface/user/domin/usecase/get_chat_between_user_use_case.dart';
import 'package:moface/user/domin/usecase/listenToMessage.dart';
import 'package:moface/user/domin/usecase/refresh_token_usecase.dart';
import 'package:moface/user/domin/usecase/register_usecase.dart';
import 'package:moface/user/domin/usecase/send_message_usecase.dart';

import '../user/data/datasource/remote_user_datasource.dart';
import '../user/domin/usecase/add_post_usecase.dart';
import '../user/domin/usecase/change_user_images.dart';
import '../user/domin/usecase/comments_usecase.dart';
import '../user/domin/usecase/get_my_suggestions_friends_usecase.dart';
import '../user/domin/usecase/get_post_data_usecase.dart';
import '../user/domin/usecase/get_post_with_my_friends_usecase.dart';
import '../user/domin/usecase/login_usecase.dart';
import '../user/domin/usecase/logout_usecase.dart';
import '../user/domin/usecase/reacts_manager_usercase.dart';
import '../user/domin/usecase/requests_usecase.dart';
import '../user/domin/usecase/save_connection_usecase.dart';
import '../user/domin/usecase/update_post_usecase.dart';
import '../user/domin/usecase/view_all_user_post_usecase.dart';

final instance = GetIt.instance;

class ServiceLocator {
  void init() {
    //use case for user

    //authentication
    instance.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(instance()));
    instance
        .registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerLazySingleton<RefreshTokenUseCase>(
        () => RefreshTokenUseCase(instance()));
    instance.registerLazySingleton<EnsureTokenValidationUseCase>(
        () => EnsureTokenValidationUseCase(instance()));
    instance
        .registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(instance()));
    instance.registerLazySingleton<GWTUseCase>(() => GWTUseCase(instance()));
    //posts
    instance.registerLazySingleton<AddPostUseCase>(
        () => AddPostUseCase(instance()));
    instance.registerLazySingleton<ViewAllUserPostUseCase>(
        () => ViewAllUserPostUseCase(instance()));
    instance.registerLazySingleton<GetPostDataUseCase>(
        () => GetPostDataUseCase(instance()));
    instance.registerLazySingleton<UpdatePostUseCase>(
        () => UpdatePostUseCase(instance()));
    instance.registerLazySingleton<DeletePostUseCase>(
        () => DeletePostUseCase(instance()));
    instance.registerLazySingleton<GetPostWithMyFriendsUseCase>(
        () => GetPostWithMyFriendsUseCase(instance()));
    //friends
    instance.registerLazySingleton<FriendsDataUseCase>(
        () => FriendsDataUseCase(instance()));
    instance.registerLazySingleton<GetMySuggestionsFriendsUseCase>(
        () => GetMySuggestionsFriendsUseCase(instance()));
    instance.registerLazySingleton<RequestRecieveUseCase>(
        () => RequestRecieveUseCase(instance()));
    instance.registerLazySingleton<RequestSendUseCase>(
        () => RequestSendUseCase(instance()));
    instance.registerLazySingleton<SendRequestUseCase>(
        () => SendRequestUseCase(instance()));
    instance.registerLazySingleton<AcceptRequestUseCase>(
        () => AcceptRequestUseCase(instance()));
    instance.registerLazySingleton<CancelRequestUseCase>(
        () => CancelRequestUseCase(instance()));
    //chat
    instance.registerLazySingleton<ConnectToWebSocketUseCase>(
            () => ConnectToWebSocketUseCase(instance()));
    instance.registerLazySingleton<SendMessageUseCase>(
            () => SendMessageUseCase(instance()));
    instance.registerLazySingleton<CloseConnectionUseCase>(
            () => CloseConnectionUseCase(instance()));
    instance.registerLazySingleton<GetChatBetweenUserUseCase>(
            () => GetChatBetweenUserUseCase(instance()));

    //comments
    instance.registerLazySingleton<AddCommentUseCase>(
        () => AddCommentUseCase(instance()));
    instance.registerLazySingleton<DeleteCommentUseCase>(
        () => DeleteCommentUseCase(instance()));
    instance.registerLazySingleton<UpdateCommentUseCase>(
        () => UpdateCommentUseCase(instance()));
    //react
    instance.registerLazySingleton<AddReactUseCase>(
        () => AddReactUseCase(instance()));
    instance.registerLazySingleton<DeleteReactUseCase>(
        () => DeleteReactUseCase(instance()));

    //user
    instance.registerLazySingleton<ChangeBackgroundImageUseCase>(
        () => ChangeBackgroundImageUseCase(instance()));
    instance.registerLazySingleton<ChangeProfileImageUseCase>(
        () => ChangeProfileImageUseCase(instance()));

    //repository user
    instance.registerLazySingleton<BaseUserRepository>(
        () => UserRepository(instance()));
    //data source user
    instance.registerLazySingleton<BaseRemoteUserDataSource>(
        () => RemoteUserDataSource());
  }
}
