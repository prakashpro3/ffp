import 'package:flutter/material.dart';

class StackAndPositionedView extends StatelessWidget {
  const StackAndPositionedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Stack and positioned"),),
        ),
        //body:setStackPositionedAlignView(context)
        //body:setAspectRatioView(context)
        //body:setFlexibleView()
        //body:setFractionallySizedBoxView()
        body:setSingleChildScrollView()
    );

  }

  Widget setStackPositionedAlignView(BuildContext context){
    var mediaQuery = MediaQuery.of(context);
    var deviceWidth = mediaQuery.size.width;
    var deviceHeight = mediaQuery.size.height;
    if(mediaQuery.orientation == Orientation.landscape){
      deviceWidth = deviceWidth / 2;
      deviceHeight = deviceHeight / 2;
    }
    return Stack(
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
              child: Align(
                alignment: Alignment.centerRight,
                //alignment: Alignment(-1, 0),
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/placeholder.png')),
              ),
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
      );
  }

  Widget setAspectRatioView(BuildContext context){
    var mediaQuery = MediaQuery.of(context);
    var deviceWidth = mediaQuery.size.width;
    var deviceHeight = mediaQuery.size.height;
    if(mediaQuery.orientation == Orientation.landscape){
      deviceWidth = deviceWidth / 2;
      deviceHeight = deviceHeight / 2;
    }
    return Container(
        width: double.infinity,
        color: Colors.lightBlue,
        child: Column(
          children: [
            Container(
              width: deviceWidth/2,
              height: deviceHeight/2,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 2/2,
                child: Container(
                  //width: deviceWidth * 0.5,
                  //height: deviceHeight * 0.29,
                  color: Colors.orange,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: 100,
                maxHeight: 100
              ),
              child: Container(
                color: Colors.yellow,
                child: Text("abcdefghijklmnopqrstuvwxyzAabcdefghijklmnopqrstuvwxyz", style: TextStyle(
                  fontSize: 20,
                  overflow: TextOverflow.fade,
                  backgroundColor: Colors.orange,
                ),),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 100,
                maxWidth: 110,
                minHeight: 50,
                maxHeight: 200
              ),
              child: ElevatedButton(onPressed: (){},
                  child: Text("Click Me if you can. You can? ffhgh")),
            )
          ],
        ),
      );
  }

  Widget setExpandedView(){
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            height: 100,
            color: Colors.red,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            height: 100,
            color: Colors.yellow,
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            height: 100,
            color: Colors.blue
          ),
        )
      ],
    );
  }

  Widget setFlexibleView(){
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            width: double.infinity,
            height: 100,
            color: Colors.red,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            width: double.infinity,
            height: 500,
            color: Colors.yellow,
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
              width: double.infinity,
              height: 150,
              color: Colors.blue
          ),
        )
      ],
    );
  }

  Widget setFractionallySizedBoxView(){
    return Container(
      alignment: Alignment.center,
      child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 0.9,
        child: Container(
          color: Colors.yellow,
        ),
      ),
    );
  }

  Widget setSingleChildScrollView(){
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10,top: 10, bottom: 10),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 400,
                  width: 250,
                  color: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 400,
                    width: 250,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  height: 400,
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Container(
                  height: 400,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
