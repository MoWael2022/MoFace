import 'package:bloc/bloc.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/base_auth_state.dart';

import '../../domin/usecase/gwt_use_case.dart';

abstract class BaseAuthCubit extends Cubit<BaseAuthState> {
  GWTUseCase gwtUseCase;

  BaseAuthCubit({required this.gwtUseCase}) : super(InitState());

  Future<String> gwt(String token) async {
    final data = await gwtUseCase.call(token);
    String decryptToken = '';
    data.fold((l) {}, (r) {
      decryptToken = r;
    });
    return decryptToken;
  }
}
