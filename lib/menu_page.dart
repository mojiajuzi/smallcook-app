import 'package:flutter/material.dart';


class MenuPage extends StatelessWidget {

  MenuPage(num id){
    this.id = id;
  }

   num id;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title:new Text('菜单')),
      body: new Container(
        child: new Column(
          children: <Widget>[
            _getMenuList(context)
          ],
        ),
      ),
    );
  }
}



Widget _getMenuList(BuildContext context){
List<FoodMenu> categoryList = _getFoodMenu();
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

class FoodMenu {
  final num id;
  final String name;

  final String descript;

  final IconData image;

  FoodMenu(this.id, this.name, this.descript, this.image);
}

_getFoodMenu(){
  List<FoodMenu> menuList = [
    new FoodMenu(1, 'A', 'this is Descript about the food', Icons.https),
    new FoodMenu(2, 'B', 'this is Descript about the food', Icons.book),
    new FoodMenu(3, 'C', 'this is Descript about the food', Icons.tablet),
    new FoodMenu(4, 'D', 'this is Descript about the food', Icons.child_care),
    new FoodMenu(5,'E', 'this is Descript about the food', Icons.favorite),
    new FoodMenu(6,'F', 'this is Descript about the food', Icons.favorite),
  ];
  return menuList;
}