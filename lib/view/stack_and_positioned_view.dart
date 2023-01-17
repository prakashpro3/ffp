import 'package:flutter/material.dart';

class StackAndPositionedView extends StatelessWidget {
  const StackAndPositionedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var deviceWidth = mediaQuery.size.width;
    var deviceHeight = mediaQuery.size.height;
    if(mediaQuery.orientation == Orientation.landscape){
      deviceWidth = deviceWidth / 2;
      deviceHeight = deviceHeight / 2;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Stack and positioned"),),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: Container(
              width: deviceWidth * 0.5,
              height: deviceHeight * 0.29,
              color: Colors.blue,
            ),
          ),
          Positioned(
            top: 50,
            left: 50,
            child: Column(
              children: [
                Container(
                  width: deviceWidth * 0.5,
                  height: deviceHeight * 0.29,
                  color: Colors.red,
                ),
                Container(
                  width: deviceWidth * 0.5,
                  height: deviceHeight * 0.29,
                  color: Colors.green,
                )
              ],
            ),
          ),
          Positioned(
            top: 70+deviceWidth * 0.5,
            left: 65,
            child: Container(
              width: deviceWidth * 0.5,
              height: deviceHeight * 0.29,
              color: Colors.pink,
            ),
          ),
          Positioned(
            top: 80,
            left: 80,
            child: Container(
              width: deviceWidth * 0.5,
              height: deviceHeight * 0.29,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
