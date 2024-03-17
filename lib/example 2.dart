//import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class eample2 extends StatefulWidget {
  const eample2({Key? key}) : super(key: key);

  @override
  State<eample2> createState() => _eample2State();
}

class _eample2State extends State<eample2> {
  List<Photos> photosList=[];
  Future<List<Photos>> getPhotos () async{
    final responce = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
var data = jsonDecode(responce.body.toString());
    if(responce.statusCode == 200){
      for(Map i in data){
        Photos photos=Photos(title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;

    }else{
      return photosList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest ap part 2'),
      ),
      body:Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context,AsyncSnapshot<List<Photos>> snapshot){
              return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context ,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  title: Text(snapshot.data![index].title.toString()),
                );
    });
    }),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title, url;

  Photos({required this.title,required this.url});
}