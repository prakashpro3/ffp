import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fpp/main.dart';
import 'package:fpp/utils/routes/app_routes.dart';
import 'package:fpp/view_model/app_setting_view_model.dart';
import 'package:fpp/view_model/user_list_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../res/constants.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/bottom_navigation_scroll_listener.dart';
import '../view_model/user_view_model.dart';
import 'tab_bar_screen.dart';

class ListScreen extends StatefulWidget {
  final ScrollController scrollController;
  const ListScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {

  UserListViewModel userListViewModel = UserListViewModel();

  @override
  void initState() {
    userListViewModel.getMemesList();
    super.initState();
  }

  @override
  void dispose() {
    userListViewModel.dispose();
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List screen'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<UserListViewModel>(
        create: (BuildContext context) => userListViewModel,
        child: Consumer<UserListViewModel>(
            builder: (context, value, _){
              switch(value.memeList.status!){
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.userList.message.toString()));
                case Status.COMPLETED:
                  var data = value.memeList.data?.data?.memes;
                  return ListView.builder(
                    controller: widget.scrollController,
                      itemCount: data?.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: ListTile(

                            leading: Image.network(

                              data![index].url.toString(),
                              errorBuilder: (context, error, stack){
                                return const Icon(Icons.error, color: Colors.red,);
                              },
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                            title: Text(data[index].name.toString()),
                            subtitle: Text(data[index].id.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(''),
                              ],
                            ),
                          ),
                        );
                      });
              }
            }),
      ) ,
    );
  }
}