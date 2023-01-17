import 'package:flutter/material.dart';

class GridViewScreen extends StatelessWidget {
  const GridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GridView")),
      //body: gridWithColumnCount(2)
      //body: gridWithViewSize(200)
      //body: gridWithDynamicBuilderWithColumnCount(4)
      body: gridWithDynamicBuilderWithViewSize(180, 10)
    );
  }


  Widget gridWithColumnCount(int count){
    return GridView.count(crossAxisCount: count,
      children: [
        Container(
          color: Colors.pink,
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.blue,
        ),
      ],
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,);
  }

  Widget gridWithViewSize(double size){
    return GridView.extent(maxCrossAxisExtent: size,
      children: [
        Container(
          color: Colors.pink,
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.blue,
        ),
      ],
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );
  }

  Widget gridWithDynamicBuilderWithColumnCount(int count){
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10
    ),
      itemBuilder: (context, index) {
      return Container(
        color: Colors.blue,
      );
    },
    itemCount: 10,);
  }

  Widget gridWithDynamicBuilderWithViewSize(double size, int itemSize){
    return GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: size,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10
    ),
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          shadowColor: Colors.blueAccent,
          child: Container(
            color: Colors.white,
          ),
        );
      },
      itemCount: itemSize,);
  }
}
