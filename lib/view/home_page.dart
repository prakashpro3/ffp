import 'package:flutter/material.dart';
import 'package:fpp/view/error_screen.dart';
import 'package:fpp/view/tab_bar_screen.dart';
import 'package:fpp/view_model/drawer_view_model.dart';
import 'package:provider/provider.dart';

import 'contact_us_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  final drawerItems = [
    DrawerItem("Contact us", Icons.rss_feed),
    DrawerItem("List view", Icons.local_pizza),
    DrawerItem("Fragment 3", Icons.info)
  ];

  List<Widget> pages = [
    const ContactUsScreen(name: 'Test',),
    const TabBarScreen(initTab: CurrentTab.contactus),
    const ErrorScreen(error: 'Home')
  ];

  @override
  Widget build(BuildContext context) {
    var drawerProvider = Provider.of<DrawerViewModel>(context,listen: true);
    drawerProvider.isRemoveRepeatedScreen = false;
    drawerProvider.setDrawerMenus(drawerItems, pages);
    return WillPopScope(
      onWillPop: ()async{
        return drawerProvider.checkBackStack();
      },
      child: Scaffold(
        appBar: AppBar(
          // here we display the title corresponding to the fragment
          // you can instead choose to have a static title
          title: Text(drawerProvider.drawerItems[drawerProvider.selectedDrawerIndex].title),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                  accountName: Text("John Doe"), accountEmail: Text('pro@gmail.com')),
              Column(children: drawerProvider.setDrawerOptions(context))
            ],
          ),
        ),
        //body: _getDrawerItemWidget(_selectedDrawerIndex),
        body: IndexedStack(
          index: drawerProvider.selectedDrawerIndex,
          children: drawerProvider.getPages(),
        ),
      ),);
  }
}