import 'package:bloc/bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';

abstract class BaseFriendsCubit extends Cubit<BaseFriendState> {
  BaseFriendsCubit() : super(InitState());



}
