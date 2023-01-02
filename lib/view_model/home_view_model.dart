import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/response/api_response.dart';
import '../model/movies_model.dart';
import '../respository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {

  HomeRepository _myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response){
    moviesList = response ;
    notifyListeners();
  }


  Future<void> fetchMoviesListApi ()async{

    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value){

      setMoviesList(ApiResponse.completed(value));

    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      setMoviesList(ApiResponse.error(error.toString()));

    });
  }


}