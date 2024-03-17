import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi1/models/UserModel.dart';


class example3 extends StatefulWidget {
  const example3({Key? key}) : super(key: key);

  @override
  State<example3> createState() => _example3State();
}

class _example3State extends State<example3> {

 List<UserModel> userList = [];
Future<List<UserModel>> getUserApi()async{

  final responce= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  var data = jsonDecode(responce.body.toString());
  if (responce.statusCode == 200){
    for(Map i in data){

      userList.add(UserModel.fromJson(i));

    }

    return userList;
  } else{

    return userList;
  }

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('api'),
      ),

      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot){

                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }else{
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context , index){
                        return Card(
                          child: Column(
                            children: [
                              
                              reusablerow(title: 'name', value: snapshot.data![index].name.toString()),
                              reusablerow(title: 'username', value: snapshot.data![index].username.toString()),
                              reusablerow(title: 'email', value: snapshot.data![index].email.toString()),
                              reusablerow(title: 'geo', value: snapshot.data![index].address!.geo!.lat.toString()),
                              reusablerow(title: 'address', value: snapshot.data![index].address!.city.toString()),

                            ],

                          ),
                        );
                      }); }


  },
              ),
          )
        ],
      ),

    );
  }
}
 class reusablerow extends StatelessWidget {
  String title , value;
   reusablerow({Key? key, required this.title , required this. value}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(title),
           Text(value),
         ],

       ),
     );
   }
 }
