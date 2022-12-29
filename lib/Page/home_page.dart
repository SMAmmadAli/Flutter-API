import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api/Models/photo_model.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PhotesModel> postList = [];

  Future<List<PhotesModel>> getPostApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PhotesModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
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
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 100,
                                      minHeight: 260,
                                      maxWidth: 104,
                                      maxHeight: 264,
                                    ),
                                    child: Image.network(
                                        postList[index].url.toString(),
                                        fit: BoxFit.cover),
                                  ),
                                  title: Text("Item No." +
                                      postList[index].id.toString()),
                                  subtitle: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(postList[index].title.toString()),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      4, 1.5, 4, 1.5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.green,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: const Text(
                                                "Email",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      4, 1.5, 4, 1.5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.green,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: const Text(
                                                "CALL",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.whatsapp,
                                                color: Colors.green,
                                              )),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          );
                          // return Card(
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(postList[index].title.toString()),
                          //       Text(postList[index].title.toString())
                          //     ],
                          //   ),
                          // );
                        }));
                  }
                }),
          )
        ],
      ),
    );
  }
}
