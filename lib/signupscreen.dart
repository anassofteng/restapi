import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void login(String email, password) async{
    try{
      Response response =await post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email': email,
          'password': password,
        }
      );
      if(response.statusCode == 200){
       var data = jsonDecode(response.body.toString());
       print(data);
       print('account created succesfully');
        print('account created successfully');
      }else{
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Signup'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'password'
              ),
            ),
          ),
          SizedBox(height: 20,),

          GestureDetector(
            onTap: (){
              login(emailController.text.toString(),passwordController.text.toString());
            },
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('Sign up')),
            ),
          ),

        ],

      ),
    );
  }
}
