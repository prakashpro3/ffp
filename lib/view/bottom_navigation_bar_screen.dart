import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fpp/utils/utils.dart';
import 'package:fpp/view/contact_us_screen.dart';
import 'package:fpp/view/home_page.dart';
import 'package:fpp/view/list_screen.dart';

import '../model/menu_item.dart';
import '../view_model/bottom_navigation_scroll_listener.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final menuItemList = [
    MenuItem(Icons.home, 'Home'),
    MenuItem(Icons.shopping_basket, 'Products'),
    MenuItem(Icons.person, 'Me'),

  ];
  int index = 0;
  getScreens(ScrollController scrollController){
    final buildBody = [const HomePage(), ListScreen(scrollController: scrollController), const ContactUsScreen(name: 'Pro')];
    return buildBody;
  }

  // Scroll controller for menu
  late ScrollController _scrollController;
  double position = 0.0;
  double sensitivityFactor = 20.0;
  ScrollDirection scrollDirection = ScrollDirection.idle;

  // Init state
  @override
  void initState() {
    _scrollController = ScrollController();
  }

  // dispose it as well
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  final ScrollController _controller = ScrollController();
  final double _bottomNavBarHeight = kBottomNavigationBarHeight;
  late final ScrollListener _model = ScrollListener.initialise(_controller);
  /*@override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      bottomNavigationBar: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, child) {
          if (_scrollController.hasClients && _scrollController.position.pixels - position >=
              sensitivityFactor) {
            scrollDirection = ScrollDirection.reverse;
            position = _scrollController.position.pixels;
          }
          if (_scrollController.hasClients && position - _scrollController.position.pixels >=
              sensitivityFactor) {
            scrollDirection = ScrollDirection.forward;
            position = _scrollController.position.pixels;
          }
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
          height: scrollDirection == ScrollDirection.reverse ? 10 : kBottomNavigationBarHeight,
          child: SizedBox(
            height: scrollDirection == ScrollDirection.reverse ? 0 : kBottomNavigationBarHeight,
            child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(2, -2),
                      ),
                    ]),
                    child: BottomNavigationBar(
                      selectedItemColor: Colors.blue,
                      unselectedItemColor: Colors.black,
                      elevation: 16.0,
                      type: BottomNavigationBarType.shifting,
                      currentIndex: index,
                      onTap: (x){
                        setState(() {
                          index = x;
                        });
                      },
                      items: menuItemList
                          .map((item) => BottomNavigationBarItem(
                          icon: Icon(item.icon),
                          label: item.name
                      )).toList(),
                    )),
          ),);
        },
      ),
      //body: _buildBody[index],
      body: IndexedStack(index: index, children: getScreens(_scrollController)),
    ));
  }*/

  late Animation<double> fadeAnimation;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: AnimatedBuilder(
        animation: _model,
        builder: (context, child) {
          return Stack(
            children: [
              IndexedStack(
                index: index,
                children: [
                  for (int i = 0; i < getScreens(_controller).length; i++)
                    getScreens(_controller)[i]
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: _model.bottom,
                child: _bottomNavBar,
              ),
            ],
          );
        },
      )
    ));
  }
  Widget get _bottomNavBar {
    return SizedBox(
      height: _bottomNavBarHeight,
      child: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        elevation: 16.0,
        type: BottomNavigationBarType.shifting,
        currentIndex: index,
        onTap: (x){
          setState(() {
            index = x;
          });
        },
        items: menuItemList
            .map((item) => BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.name
        )).toList(),
      ),
    );
  }
}
