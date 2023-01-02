import 'package:flutter/material.dart';
import 'package:fpp/view_model/user_list_view_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../model/User_list_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/home_view_model.dart';
import '../view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  //HomeViewViewModel  homeViewViewModel = HomeViewViewModel();
  UserListViewModel userListViewModel = UserListViewModel();

  @override
  void initState() {
    //homeViewViewModel.fetchMoviesListApi();
    userListViewModel.getUserList(1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: (){
                userPreference.remove().then((value){
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: const Center(child: Text('Logout'))),
          const SizedBox(width: 20,)
        ],
      ),
      body: ChangeNotifierProvider<UserListViewModel>(
        create: (BuildContext context) => userListViewModel,
        child: Consumer<UserListViewModel>(
            builder: (context, value, _){
              switch(value.userList.status){
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.userList.message.toString()));
                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount: value.userList.data?.data?.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: ListTile(

                            leading: Image.network(

                              value.userList.data!.data![index].avatar.toString(),
                              errorBuilder: (context, error, stack){
                                return const Icon(Icons.error, color: Colors.red,);
                              },
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                            title: Text(value.userList.data!.data![index].firstName.toString()),
                            subtitle: Text(value.userList.data!.data![index].lastName.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(value.userList.data!.data![index].email.toString()),
                              ],
                            ),
                          ),
                        );
                      });
              }
              return Container();
            }),
      ) ,
    );
  }
}