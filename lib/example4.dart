import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class example4 extends StatefulWidget {
  const example4({Key? key}) : super(key: key);

  @override
  State<example4> createState() => _example4State();
}

class _example4State extends State<example4> {
var data;
  Future<void> getuserapi() async{
    final responce=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(responce.statusCode == 200){
      data= jsonDecode(responce.body.toString());

    }else{
      return ;
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hi'),),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getuserapi(),
            builder: (context , snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
return Text('loading');
              }else{

                return ListView.builder(
                    itemCount: data.length ,
                    itemBuilder: (context,index){
                  return Card(
                    child: Column(
                      children: [
                        reusablerow(title: 'name', value: data[index]['name'].toString(), ),
                        reusablerow(title: 'username', value: data[index]['username'].toString(), ),
                        reusablerow(title: 'address', value: data[index]['address']['street'].toString(),),
                        reusablerow(title: 'address', value: data[index]['address']['street']['geo'].toString(),),
                        reusablerow(title: 'address', value: data[index]['name']['street']['gep']['lat'].toString(),),

                      ],
                    ),
                  );
                });

              }

            },
          ),)
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
