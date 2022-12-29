import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/Models/posts_model.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loading');
                  } else {
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(postList[index].title.toString()),
                                Text(postList[index].title.toString())
                              ],
                            ),
                          );
                        }));
                  }
                }),
          )
        ],
      ),
    );
  }
}
