import 'package:flutter/material.dart';
import 'package:fpp/data/response/api_response.dart';
import 'package:fpp/respository/user_list_repository.dart';

import '../model/user_list_model.dart';

class UserListViewModel with ChangeNotifier{
  UserListRepository _userListRepository = UserListRepository();

  ApiResponse<UserListModel> userList = ApiResponse.loading();

  setUserList(ApiResponse<UserListModel> apiResponse){
    userList = apiResponse;
    notifyListeners();
  }

  getUserList(int pageNumber){

    setUserList(ApiResponse.loading());

    _userListRepository.fetchUserList(pageNumber).then((value) => {

      setUserList(ApiResponse.completed(value))

    }).onError((error, stackTrace) => {

      setUserList(ApiResponse.error(error.toString()))

    });
  }
}