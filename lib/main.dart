import 'package:flutter/material.dart';
import 'menu_page.dart';


void main()=>runApp(new HomePage());


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'homepage',
      home: new Scaffold(
        appBar: new AppBar(title: new Text('Card'),),
        body: new Container(
          child: new Column(
           children: <Widget>[
             getListCategory(context)
           ],
          )
        ),
      ),
    );
  }
}

Widget getListCategory(BuildContext context){

  List<FoodCategory> categoryList = _getFoodCategory();
  return new Flexible(
    child: new ListView.builder(
      itemCount: categoryList.length,
      itemBuilder: (context, index){
        return new Card(
          child: new ListTile(
            leading: new Icon(categoryList[index].image, size: 50.0,),
            title: new Text(categoryList[index].name),
            subtitle: new Text(categoryList[index].descript),
            isThreeLine: true,
            onLongPress: null,
            onTap: (){
              Navigator.of(context).push(new PageRouteBuilder(
                opaque: true,
                pageBuilder: (BuildContext context, _, __){
                  return new MenuPage(categoryList[index].id);
                },
                transitionsBuilder: (_, Animation<double> animation, __, Widget chile){
                  return new FadeTransition(
                    opacity: animation,
                    child: new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero
                      ).animate(animation), child: chile,
                    ),
                  );
                }
              ));
            },
          ),
        );
      },
    ),
  );
}

class FoodCategory {
  final num id;
  final String name;

  final String descript;

  final IconData image;

  FoodCategory(this.id, this.name, this.descript, this.image);
}

_getFoodCategory(){
  List<FoodCategory> foodcategory = [
    new FoodCategory(1, '甜品', 'this is Descript about the food', Icons.https),
    new FoodCategory(2, '小吃', 'this is Descript about the food', Icons.book),
    new FoodCategory(3, '西餐', 'this is Descript about the food', Icons.tablet),
    new FoodCategory(4, '中餐', 'this is Descript about the food', Icons.child_care),
    new FoodCategory(5,'水果', 'this is Descript about the food', Icons.favorite),
    new FoodCategory(6,'汤', 'this is Descript about the food', Icons.favorite),
  ];
  return foodcategory;
}