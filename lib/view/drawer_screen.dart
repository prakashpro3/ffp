import 'package:flutter/material.dart';
import 'package:fpp/res/constants.dart';
import 'package:fpp/utils/routes/routes_name.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _drawerScreen();
  }
}

class _drawerScreen extends State<DrawerScreen>{
  final GlobalKey<ScaffoldState> _Key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _Key,
      appBar: AppBar(
        title: const Text('Drawer'),
        centerTitle: true,
      ),
      drawer: SafeArea(child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text('Pro'),
                accountEmail: Text('Pro@gmail.com'),
                currentAccountPicture: FlutterLogo(),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(localise(context).home),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RoutesName.home);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: Text(localise(context).login),
              ),
              ListTile(
                leading: const Icon(
                    Icons.app_registration
                ),
                title: Text(localise(context).sing_up),
              ),
              const AboutListTile(
                icon: Icon(Icons.info),
                applicationIcon: Icon(Icons.local_play),
                applicationName: 'Flutter App',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2023 Pro',
                aboutBoxChildren: [
                  SizedBox(height: 20,),
                  Text('This is Flutter app')
                ],
                child: Text('About app'),
              ),
            ],
          ),
        ),
      )),
      body: Center(
        child: ElevatedButton(
          child: const Text('Click me'),
          onPressed: () {
            _Key.currentState?.openDrawer();
          },
        ),
      ),
    );
  }
}
