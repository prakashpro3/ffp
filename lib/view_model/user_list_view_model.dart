import 'package:flutter/material.dart';
import 'package:fpp/data/response/api_response.dart';
import 'package:fpp/model/memes_model.dart';
import 'package:fpp/respository/user_list_repository.dart';

import '../model/user_list_model.dart';

class UserListViewModel with ChangeNotifier{
  final UserListRepository _userListRepository = UserListRepository();

  ApiResponse<UserListModel> userList = ApiResponse.loading();
  ApiResponse<MemesModel> memeList = ApiResponse.loading();

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

  setMemesList(ApiResponse<MemesModel> apiResponse){
    memeList = apiResponse;
    notifyListeners();
  }

  getMemesList(){

    setMemesList(ApiResponse.loading());

    _userListRepository.fetchMameList().then((value) => {

      setMemesList(ApiResponse.completed(value))

    }).onError((error, stackTrace) => {

      setMemesList(ApiResponse.error(error.toString()))

    });
  }
}