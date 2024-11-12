import 'package:mo_face_app/feature/user/post_feature/reacts/domin/entites/react_data_enter.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/entites/react_entities.dart';

abstract class ReactState {}

class InitState extends ReactState {}

class AddReactState extends ReactState {
  int postId ;
  AddReactState(this.postId);
}

class DeleteReactState extends ReactState {
  int postId ;
  DeleteReactState(this.postId);
}

class ErrorReactState extends ReactState {
  String message ;
  ErrorReactState(this.message);
}
