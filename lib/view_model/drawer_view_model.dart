import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../view/contact_us_screen.dart';
import '../view/error_screen.dart';
import '../view/tab_bar_screen.dart';

class DrawerViewModel with ChangeNotifier{
  var drawerItems = [DrawerItem("Home", Icons.home)];

  int selectedDrawerIndex = 0;
  bool isRemoveRepeatedScreen = false;
  List<Widget> pages = [const ErrorScreen(error: "Home Screen",)];

  List<Widget> setDrawerOptions(BuildContext context){
    List<Widget> drawerOptions = [];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
          ListTile(
            leading: Icon(d.icon),
            title: Text(d.title),
            selected: i == selectedDrawerIndex,
            onTap: () => onSelectItem(i, context),
          )
      );
    }
    return drawerOptions;
  }

  setDrawerMenus(List<DrawerItem> drawerItems, List<Widget> pages){
    if(drawerItems.length != pages.length) {
      throw InvalidScreensException();
    }
    this.drawerItems = drawerItems;
    this.pages = pages;
  }

  List<Widget> getPages(){
    Utils.setLog("checkBackStack","pages");
    if(!isBackStack){
      if(pageStack.isNotEmpty){
        if(isRemoveRepeatedScreen){
          for(int i=0; i < pageStack.length; i++){
            if(pageStack[i] == drawerItems[selectedDrawerIndex].title){
              pageStack.removeAt(i);
            }
          }
        }else if(pageStack[pageStack.length-1] == drawerItems[selectedDrawerIndex].title){
          pageStack.removeAt(pageStack.length-1);
        }
      }
      pageStack.add(drawerItems[selectedDrawerIndex].title);
    }else{
      pageStack.removeLast();
    }
    return pages;
  }

  onSelectItem(int index, BuildContext context) {
    isBackStack = false;
    selectedDrawerIndex = index;
    Navigator.of(context).pop();// close the drawer
    notifyListeners();
  }
  var pageStack = [];
  var isBackStack = false;
  Future<bool> checkBackStack()async{
    Utils.setLog("checkBackStack","pageStack.length-${pageStack.length}");
    if(pageStack.isNotEmpty && pageStack.length > 1){
      Utils.setLog("checkBackStack","checkBackStack-if");
      isBackStack = true;
      Utils.setLog("checkBackStack","_selectedDrawerIndex-before-$selectedDrawerIndex");
      var lastIndex = pageStack.length-2;
      Utils.setLog("checkBackStack","lastIndex-value-$lastIndex=${pageStack[lastIndex]}");
      for (var i = 0; i < drawerItems.length; i++) {
        var d = drawerItems[i];
        if(pageStack[lastIndex] == d.title){
          if(d.title == "Contact us"){
            selectedDrawerIndex = i;
            break;
          }else if(d.title == "List view"){
            selectedDrawerIndex = i;
            break;
          }else if(d.title == "Fragment 3"){
            selectedDrawerIndex = i;
            break;
          }else{
            isBackStack = false;
            return true;
          }
        }
      }
      notifyListeners();
      Utils.setLog("checkBackStack","_selectedDrawerIndex-after-$selectedDrawerIndex");
      return false;
    }else{
      Utils.setLog("checkBackStack","checkBackStack-else");
      isBackStack = false;
      notifyListeners();
      return true;
    }
  }


  /*_getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        var page = const ContactUsScreen(name: 'Test',);
        if(!isBackStack){
          pageStack.add(drawerItems[pos].title);
        }else{
          pageStack.removeLast();
        }
        return page;
      case 1:
        var page = const TabBarScreen(initTab: CurrentTab.contactus);
        if(!isBackStack){
          pageStack.add(drawerItems[pos].title);
        }else{
          pageStack.removeLast();
        }
        return page;

      default:
        var page = const Text("Error");
        if(!isBackStack){
          pageStack.add(drawerItems[pos].title);
        }else{
          pageStack.removeLast();
        }
        return page;
    }
  }*/
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class InvalidScreensException implements Exception {
  // can contain constructors, variables and methods
  String errMsg() => 'Amount should be greater than zero';
}