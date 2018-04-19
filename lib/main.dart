import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'menu_page.dart';


void main()=>runApp(new HomePage());


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List data;

  @override
  void initState(){
    super.initState();
    getData();
  }

  getData()async{
    var res = await getCategory();
    if(!mounted) return;
    setState(() {
          data = res;
        });
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'homepage',
      home: new Scaffold(
        appBar: new AppBar(title: new Text('Your Menu'),),
        body: new Container(
          child: new Column(
            children: <Widget>[
             getListCategory(context, data)
           ],
          )
        ),
      ),
    );
  }
}

Widget getListCategory(BuildContext context, List categoryList){

  var myLength = categoryList == null ? 0 : categoryList.length;
  return new Flexible(
    child: new ListView.builder(
      itemCount: myLength,
      itemBuilder: (context, index){
        return new Card(
          child: new ListTile(
            leading: new Image.network('https://flutter.io/images/flutter-mark-square-100.png'),
            title: new Text(categoryList[index]['name']),
            subtitle: new Text(categoryList[index]['desc']),
            isThreeLine: true,
            onLongPress: null,
            onTap: (){
              Navigator.of(context).push(new PageRouteBuilder(
                opaque: true,
                pageBuilder: (BuildContext context, _, __){
                  return new MenuPage(categoryList[index]['id']);
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
//获取请求得到的字符串
Future<List> getCategory() async {
  http.Response data = await http.get('http://10.0.2.2:8080');
  if(data.statusCode == 200)
    return jsonDecode(data.body);
  return [];
}

