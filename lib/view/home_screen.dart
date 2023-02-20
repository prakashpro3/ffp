import 'package:flutter/material.dart';
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
import '../view_model/user_view_model.dart';
import 'tab_bar_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? userData;
  const HomeScreen({Key? key, required this.userData}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  UserListViewModel userListViewModel = UserListViewModel();

  @override
  void initState() {
    userListViewModel.getUserList(1);
    super.initState();
    //Utils.snackBar(widget.userData.toString(), context);
    Utils.setLog("routeExtra", widget.userData.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    final appSettingsProvider = Provider.of<AppSettingsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localise(context).home),
        centerTitle: true,
        actions:
        [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  /*userPreference.remove().then((value){
                    //Navigator.pushNamed(context, RoutesName.login);
                    context.go(AppRouter.login);
                  });*/
                  //Navigator.pushNamed(context, RoutesName.drawerScreen);
                  context.push(AppRouter.drawerWithMultiScreen);
                },
                child: const Center(child: Icon(Icons.logout)),
              )
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                    appSettingsProvider.getAppLanguage().then((locale)async{
                      Locale lastAppLanguage = locale;
                      var lastAppLanguageCode = lastAppLanguage.languageCode;
                      var newLanguageCode = lastAppLanguageCode;
                      Utils.setLog("AppLanguage", "lastAppLanguageCode - $lastAppLanguageCode");
                      if(lastAppLanguageCode.isNotEmpty && lastAppLanguageCode == english){
                        newLanguageCode = hindi;
                      }else{
                        newLanguageCode = english;
                      }
                      Locale newAppLanguage = await appSettingsProvider.setAppLanguage(newLanguageCode);
                      MyApp.setLocal(context, newAppLanguage);
                      Utils.setLog("AppLanguage", "newAppLanguage $newLanguageCode");
                    });
                  },
                  child: const Icon(Icons.language),
              )
          ),
        ],
      ),

      drawer: SafeArea(child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text('Pro'),
                accountEmail: Text('Pro@gmail.com'),
                currentAccountPicture: Image(image: AssetImage('assets/images/placeholder.png')),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(localise(context).home),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RoutesName.homePage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: Text(localise(context).login),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                    Icons.app_registration
                ),
                title: Text(localise(context).sing_up),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_page),
                title: const Text('Contact us'),
                onTap: (){
                  context.push(AppRouter.contactUsScreenWithParams());
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_page),
                title: const Text('List view'),
                onTap: (){
                  context.push(AppRouter.listViewScreen(CurrentTab.contactus));
                },
              ),
              ListTile(
                leading: Icon(Icons.queue_play_next),
                title: const Text('BottomNavigation'),
                onTap: (){
                  context.push(AppRouter.bottomNavigationScreen);
                },
              ),
              ListTile(
                leading: const Icon(Icons.stacked_bar_chart),
                title: const Text("StackPositionedView"),
                onTap: (){
                  context.push(AppRouter.stackAndPositionedView);
                },
              ),
              ListTile(
                leading: const Icon(Icons.grid_3x3),
                title: const Text("GridView"),
                onTap: (){
                  context.push(AppRouter.gridViewScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.data_array),
                title: Text("Data table"),
                onTap: (){
                  context.push(AppRouter.dataTableScreen);
                },
              ),
              AboutListTile(
                icon: const Icon(Icons.info),
                applicationIcon: const Icon(Icons.local_play),
                applicationName: 'Flutter App',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2023 Pro',
                aboutBoxChildren: const [
                  SizedBox(height: 20,),
                  Text('This is Flutter app')
                ],
                child: Text(localise(context).about_app),
              ),
            ],
          ),
        ),
      )),

      body: ChangeNotifierProvider<UserListViewModel>(
        create: (BuildContext context) => userListViewModel,
        child: Consumer<UserListViewModel>(
            builder: (context, value, _){
              switch(value.userList.status!){
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
            }),
      ) ,
    );
  }
}