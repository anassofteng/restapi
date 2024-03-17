import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:restapi1/PostsModel.dart';
import 'package:restapi1/models/PostsModel.dart';



class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

 List<PostsModel> postList = [] ;
  Future<List<PostsModel>> getPostApi ()async{
    final responce = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  var data = jsonDecode(responce.body.toString());
    if(responce.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList ;
  }else {
      return postList;
  }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hi'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context , snapshot){
                if(!snapshot.hasData){
                  return Text('loading');
                }else {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index){
                        return Card(child : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(postList[index].title.toString()),
                              Text(postList[index].body.toString()),
                            ],
                          )
                        ) );
                  });
                }

            },
            ),
          )
        ],
      ),
    );
  }
}
