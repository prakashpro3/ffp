import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/user_list_model.dart';
import '../res/app_url.dart';

class UserListRepository {

  final BaseApiServices _apiServices = NetworkApiService() ;

  Future<UserListModel> fetchUserList(int pageNumber)async{

    try{
      print('${AppUrl.userList}$pageNumber');
      dynamic response = await _apiServices.getGetApiResponse('${AppUrl.userList}$pageNumber');
      return response = UserListModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

}