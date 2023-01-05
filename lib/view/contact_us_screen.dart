import 'package:flutter/material.dart';
import 'package:fpp/utils/utils.dart';

class ContactUsScreen extends StatefulWidget {
  final String name;
  const ContactUsScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.setLog("routeExtra", widget.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Contact us screen",style: TextStyle(fontSize: 20),),
            ElevatedButton(onPressed: (){
              setState(() {
                count++;
              });
            }, child: Text(count.toString()))
          ],
        ),
      ),
    );
  }
}
