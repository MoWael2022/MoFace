import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/presentation/controller/load_post_cubit/load_post_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service_locator.dart';
import '../../../domin/entites/posts/get_post_data.dart';
import '../../../domin/entites/posts/get_post_data_enter.dart';
import '../../../domin/usecase/get_post_data_usecase.dart';

// Cubit to manage list
class LoadPostCubit extends Cubit<BaseLoadPostState> {
  LoadPostCubit() : super(InitState());

  int currentNumberOfPost = 0;
  List<dynamic> postsId = [];
  bool isLoadingMore = false ;



  loadPosts() async {
    print(postsId.length);
    print(currentNumberOfPost);
    if (postsId.length > currentNumberOfPost &&
        state is! ProfileLoadMorePostsLoadingState) {
      emit(ProfileLoadMorePostsLoadingState());
      // for (int i = _currentNumberOfPost;
      //     i < _currentNumberOfPost + 1 && i < postsId.length;
      //     i++) {
      //   final post = await _getPostById(postsId[i]);
      //   userPosts.add(post);
      // }
      final post = await getPostById(postsId[currentNumberOfPost]);

      currentNumberOfPost +=1;

      emit(ProfileLoadMorePostsState(post));
    }
  }

  Future<GetPostData> getPostById(int id) async {
    GetPostData? post;
    final data = instance<GetPostDataUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result =
    await data.call(GetPostDataEnter(token: token, id: id, userId: idUser));
    result.fold((l) {
      print(l);
    }, (r) {
      post = r;
    });
    return post!;
  }



}
