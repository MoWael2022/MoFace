import '../../domin/entites/send_request_data_enter.dart';
import '../model/friend_data_model.dart';
import '../model/friend_data_model_for_send_requests.dart';

abstract class BaseFriendRemoteDataSource {

  Future<List<FriendDataModel>> getMyFriendsDataSource(String userId);
  Future<List<FriendDataModel>> getMySuggestionFriendsDataSource(String userId);
  Future<List<FriendDataModelForSendRequest>> getMyRequestsSendDataSource(String userId);
  Future<List<FriendDataModelForSendRequest>> getMyRequestReceiveDataSource(String userId);
  Future<bool> sendRequestDataSource (RequestDataEnter data);
  Future<bool> acceptRequestDataSource (RequestDataEnter data);
  Future<bool> cancelRequestDataSource (RequestDataEnter data);

}