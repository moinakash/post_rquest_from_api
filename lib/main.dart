import 'package:flutter/material.dart';
import 'package:post_rquest_from_api/user_model.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();



}

Future<UserModel?> createUser(String name, String jobTitle) async {
  var apiUrl = Uri.parse('https://reqres.in/api/users');
  // final String apiUrl = "https://reqres.in/api/users";

  final response =
  await http.post(apiUrl, body: {"name": name, "job": jobTitle});

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    UserModel? _user;



    final TextEditingController namController = TextEditingController();
    final TextEditingController jobController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(

          child: Column(
            children: [
              TextField(
                controller: namController,
              ),
              TextField(
                controller: jobController,
              ),
              InkWell(

                child: Container(

                  height: 40,
                  width: 40,
                  color: Colors.red,

                ),

                onTap: () async{

                  final String name = namController.text;
                  final String jobTitle = jobController.text;

                  final UserModel? user = await createUser(name, jobTitle);

                  setState(() {
                    _user = user;
                  });

                  print("${_user?.name} \n ${_user?.id} \n ${_user?.job}  ${_user?.createdAt}  ");
                  
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
