import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_cubit.dart';
import 'package:moface/user/presentation/controller/loading_cubit/data_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service_locator.dart';
import '../../../domin/entites/posts/user_view_posts.dart';
import '../../../domin/entites/userData.dart';
import '../../../domin/usecase/view_all_user_post_usecase.dart';
import '../load_post_cubit/load_post_cubit.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(LoadingState()) {
    getData();
  }

  UserData? userData;
  bool showSuggestionsScreen = false;

  navigateToSuggestion() {}

  Future<dynamic> _getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (kIsWeb) {
    //   String? base64String = prefs.getString('photoImg');
    //   Uint8List? bytes;
    //
    //   if (base64String != null) {
    //     bytes = base64Decode(base64String);
    //   }
    //   return bytes;
    // }
    return prefs.getString("photoImg");
  }

  Future<dynamic> _getBackgroundImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (kIsWeb) {
    //   String? base64String = prefs.getString('backgroundImg');
    //   Uint8List? bytes;
    //
    //   if (base64String != null) {
    //     bytes = base64Decode(base64String);
    //   }
    //   return bytes;
    // }
    return prefs.getString("backgroundImg");
  }

  Future<String> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("username") as String;
  }

  Future<String> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") as String;
  }

  // Future<List<String>> _getRules() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("rules") as List<String>;
  // }

  Future<String> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("id") as String;
  }

  getData() async {
    emit(LoadingState());
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    final email = await _getEmail();
    print(email);
    final userName = await _getUsername();
    print(userName);
    final backgroundImage = await _getBackgroundImage();
    //print(backgroundImage);
    //final rules = await _getRules();
    final id = await _getUserId();
    final photoImage = await _getProfileImage();
    userData = UserData(
        email: email,
        name: userName,
        backgroundImgge: backgroundImage,
        rules: [],
        id: id,
        token: token,
        photoImage: photoImage);
    emit(LoadedUserData(userData!));
  }

  getProfilePosts(context) async {
    emit(ProfilePostsLoadingState());
    final appCubit = BlocProvider.of<AppCubit>(context);
    final loadPostCubit = BlocProvider.of<LoadPostCubit>(context);

    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    print(id);
    final result = instance<ViewAllUserPostUseCase>();
    final data = await result.call(
      UserPostDataEnter(token: token, userId: id),
    );
    data.fold((l) {
      emit(ProfilePostsErrorState(l.messageError));
    }, (r) async {
      print("--------------------");
      print(r.postsId);
      print("--------------------");
      if(r.postsId.isEmpty){
        print('done');
        emit(ProfilePostsErrorState("No Posts Yet , let's Add Some Posts"));
      }else {
        loadPostCubit.postsId = r.postsId;
        if (appCubit.userPosts.isEmpty) {
          await initPosts(context);
        }
        emit(ProfilePostsLoadedState(appCubit.userPosts, r.postsId));
      }
    });
  }

  initPosts(context) async {
    final loadPostCubit = BlocProvider.of<LoadPostCubit>(context);
    final appCubit = BlocProvider.of<AppCubit>(context);
    for (int i = 0; i < 2 && i < loadPostCubit.postsId.length; i++) {
      final post = await loadPostCubit.getPostById(loadPostCubit.postsId[i]);
      appCubit.userPosts.add(post);
    }
    loadPostCubit.currentNumberOfPost = appCubit.userPosts.length;
  }
}
