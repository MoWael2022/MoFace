import 'package:get_it/get_it.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/login_cubit.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/register_cubit.dart';
import 'package:mo_face_app/feature/splash/controller/data_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/data/data_source/base_friend_remote_data_source.dart';
import 'package:mo_face_app/feature/user/friends_feature/data/data_source/friend_remote_data_source.dart';
import 'package:mo_face_app/feature/user/friends_feature/data/repository/friend_repository.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/repository/base_friend_repository.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/accept_request_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/cancel_send_request_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_friend_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_recieve_requests_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_send_requests_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_suggestion_friend_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/send_request_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_friend_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_recieve_request_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_send_request_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_suggestion_friend_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/manage_friend_cubit.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/data/data_source/base_comment_remote_data_source.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/data/data_source/comment_remote_data_source.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/data/repository/comment_repository.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/repository/base_comment_repository.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/usecase/add_comment_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/usecase/delete_comment_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/usecase/update_comment_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/presentation/controller/comment_cubit.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/add_post_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/delete_post_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/update_post_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/get_home_post_cubit.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/manage_profile_post.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/data/data_source/react_remote_data_source.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/data/repository/react_repository.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/repository/base_react_repository.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/usecase/add_react_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/usecase/delete_react_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/presentation/controller/react_cubit.dart';
import '../../feature/auth_feature/data/data_source/remote_data_source/base_remote_data_source.dart';
import '../../feature/auth_feature/data/data_source/remote_data_source/remote_data_source.dart';
import '../../feature/auth_feature/data/repository/repository.dart';
import '../../feature/auth_feature/domin/repository/base_repository.dart';
import '../../feature/auth_feature/domin/usecase/ensure_token_validation_usecase.dart';
import '../../feature/auth_feature/domin/usecase/gwt_use_case.dart';
import '../../feature/auth_feature/domin/usecase/login_usecase.dart';
import '../../feature/auth_feature/domin/usecase/logout_usecase.dart';
import '../../feature/auth_feature/domin/usecase/refresh_token_usecase.dart';
import '../../feature/auth_feature/domin/usecase/register_usecase.dart';
import '../../feature/payment/data/data_source/base_remote_data_source.dart';
import '../../feature/payment/data/data_source/remote_data_source.dart';
import '../../feature/payment/data/repository/repository_paymnet.dart';
import '../../feature/payment/domin/repository/base_repository_payment.dart';
import '../../feature/payment/domin/usecase/payment_usecase.dart';
import '../../feature/payment/presentation/controller/paymnet_cubit.dart';
import '../../feature/user/post_feature/main_post/data/data_source/base_remote_post_data_source.dart';
import '../../feature/user/post_feature/main_post/data/data_source/remote_posts_data_source.dart';
import '../../feature/user/post_feature/main_post/data/repository/post_repository.dart';
import '../../feature/user/post_feature/main_post/domin/repository/base_post_repository.dart';
import '../../feature/user/post_feature/main_post/domin/usecase/get{post_using_id_use_case.dart';
import '../../feature/user/post_feature/main_post/domin/usecase/home_post_use_case.dart';
import '../../feature/user/post_feature/main_post/domin/usecase/profile_post_use_case.dart';
import '../../feature/user/post_feature/main_post/presentation/controller/main_post_cubit/get_profile_post_cubit.dart';

final instance = GetIt.instance;

class ServiceLocator {
  void init() {
    //##########################################################################
    //auth feature
    instance.registerLazySingleton<BaseAuthRemoteUserDataSource>(
        () => RemoteAuthDataSource());

    instance.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepository(instance()));

    instance.registerLazySingleton<EnsureTokenValidationUseCase>(
        () => EnsureTokenValidationUseCase(instance()));
    instance.registerLazySingleton<GWTUseCase>(() => GWTUseCase(instance()));
    instance
        .registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));
    instance
        .registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(instance()));
    instance.registerLazySingleton<RefreshTokenUseCase>(
        () => RefreshTokenUseCase(instance()));
    instance.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(instance()));

    instance.registerFactory(() => LoginCubit(
        gwtUseCase: instance<GWTUseCase>(),
        loginUseCase: instance<LoginUseCase>()));

    instance.registerFactory(() => RegisterCubit(
        gwtUseCase: instance<GWTUseCase>(),
        registerUseCase: instance<RegisterUseCase>()));

    //##########################################################################
    //splash feature
    instance.registerFactory(() => DataCubit());

    //##########################################################################
    //payment feature

    instance.registerLazySingleton<PaymentUseCase>(
        () => PaymentUseCase(instance()));
    //repository
    instance.registerLazySingleton<BaseRepositoryPayment>(
        () => RepositoryPayment(instance()));
    //data source user
    instance.registerLazySingleton<BasePaymentRemoteDataSource>(
        () => PaymentRemoteDataSource());

    //cubit
    instance.registerFactory(() => PaymentCubit(instance<PaymentUseCase>()));

    //##########################################################################
    //##########################################################################
    //post feature
    //##########################################################################
    //1 - get post feature
    instance.registerLazySingleton<BaseRemotePostDataSource>(
        () => RemotePostsDataSource());

    instance.registerLazySingleton<BasePostRepository>(
        () => PostRepository(instance()));

    instance.registerLazySingleton<GetProfilePostUseCase>(
        () => GetProfilePostUseCase(instance()));
    instance.registerLazySingleton<HomePostUseCase>(
        () => HomePostUseCase(instance()));
    instance.registerLazySingleton<GetPostByIdUseCase>(
        () => GetPostByIdUseCase(instance()));
    instance.registerLazySingleton<AddPostUseCase>(
        () => AddPostUseCase(instance()));
    instance.registerLazySingleton<UpdatePostUseCase>(
        () => UpdatePostUseCase(instance()));
    instance.registerLazySingleton<DeletePostUseCase>(
        () => DeletePostUseCase(instance()));

    instance.registerFactory(() => GetHomePostCubit(
        homePostUseCase: instance<HomePostUseCase>(),
        getPostByIdUseCase: instance<GetPostByIdUseCase>()));

    instance.registerFactory(
      () => GetProfilePostCubit(
          profilePostUseCase: instance<GetProfilePostUseCase>(),
          getPostByIdUseCase: instance<GetPostByIdUseCase>()),
    );

    instance.registerFactory(() => ManageProfilePost(
          profilePostUseCase: instance<GetProfilePostUseCase>(),
          getPostByIdUseCase: instance<GetPostByIdUseCase>(),
          addPostUseCase: instance<AddPostUseCase>(),
          deletePostUseCase: instance<DeletePostUseCase>(),
          updatePostUseCase: instance<UpdatePostUseCase>(),
        ));

    //##########################################################################
    // 2- comment feature
    instance.registerLazySingleton<BaseCommentRemoteDataSource>(
        () => CommentRemoteDataSource());

    instance.registerLazySingleton<BaseCommentRepository>(
        () => CommentRepository(instance()));

    instance.registerLazySingleton<AddCommentUseCase>(
        () => AddCommentUseCase(instance()));

    instance.registerLazySingleton<DeleteCommentUseCase>(
        () => DeleteCommentUseCase(instance()));

    instance.registerLazySingleton<UpdateCommentUseCase>(
        () => UpdateCommentUseCase(instance()));

    instance.registerFactory(() => CommentCubit(
          addCommentUseCase: instance<AddCommentUseCase>(),
          deleteCommentUseCase: instance<DeleteCommentUseCase>(),
          updateCommentUseCase: instance<UpdateCommentUseCase>(),
        ));

    //##########################################################################
    // 3 - react feature

    instance.registerLazySingleton<ReactRemoteDataSource>(
        () => ReactRemoteDataSource());

    instance.registerLazySingleton<BaseReactRepository>(
        () => ReactRepository(instance()));

    instance.registerLazySingleton<AddReactUseCase>(
        () => AddReactUseCase(instance()));

    instance.registerLazySingleton<DeleteReactUseCase>(
        () => DeleteReactUseCase(instance()));

    instance.registerFactory(() => ReactCubit(
          addReactUseCase: instance<AddReactUseCase>(),
          deleteReactUseCase: instance<DeleteReactUseCase>(),
        ));
    //##########################################################################
    //##########################################################################
    //Friend Feature
    //##########################################################################
    //remote Data source
    instance.registerLazySingleton<BaseFriendRemoteDataSource>(
        () => FriendRemoteDataSource());

    //Repository
    instance.registerLazySingleton<BaseFriendRepository>(
        () => FriendRepository(instance()));

    //Use case
    instance.registerLazySingleton<GetMyFriendUseCase>(
        () => GetMyFriendUseCase(instance()));
    instance.registerLazySingleton<GetSuggestionFriendUseCase>(
        () => GetSuggestionFriendUseCase(instance()));
    instance.registerLazySingleton<GetMySendRequestsUseCase>(
        () => GetMySendRequestsUseCase(instance()));
    instance.registerLazySingleton<GetMyReceiveRequestUseCase>(
        () => GetMyReceiveRequestUseCase(instance()));
    instance.registerLazySingleton<AcceptRequestUseCase>(
        () => AcceptRequestUseCase(instance()));
    instance.registerLazySingleton<CancelRequestUseCase>(
        () => CancelRequestUseCase(instance()));
    instance.registerLazySingleton<SendRequestUseCase>(
        () => SendRequestUseCase(instance()));

    //Cubit

    instance.registerFactory(() => GetMyFriendCubit(
          getMyFriendUseCase: instance<GetMyFriendUseCase>(),
        ));
    instance.registerFactory(() => GetSuggestionFriendCubit(
          getSuggestionFriendUseCase: instance<GetSuggestionFriendUseCase>(),
        ));
    instance.registerFactory(() => GetMySendRequestCubit(
          getMySendRequestsUseCase: instance<GetMySendRequestsUseCase>(),
        ));
    instance.registerFactory(() => GetMyReceiveRequestCubit(
          getMyReceiveRequestUseCase: instance<GetMyReceiveRequestUseCase>(),
        ));
    instance.registerFactory(() => ManageFriendCubit(
          acceptRequestUseCase: instance<AcceptRequestUseCase>(),
          cancelRequestUseCase: instance<CancelRequestUseCase>(),
          sendRequestUseCase: instance<SendRequestUseCase>(),
        ));
  }
}
