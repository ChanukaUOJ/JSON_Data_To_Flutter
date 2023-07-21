// ignore: file_names
import 'dart:ffi';

import 'package:backend_data_http_pkg/RestApiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'User.dart';
import 'UserScreen.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final apiService = RestApiService();

  List<bool> favouriteStateList = [];
  List<User> favouritedUserList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiService.getUser().then((value) {
      if (value.isNotEmpty) {
        for (User user in value) {
          favouriteStateList.add(false);
        }
      }
    });
  }

  _getFavouriteIcon(int index) {
    if (favouriteStateList[index]) {
      return Icon(
        Icons.favorite,
        color: Colors.red[400],
      );
    } else {
      return Icon(
        Icons.favorite_outline,
        color: Colors.red[400],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("List Page")),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: apiService.getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => UserScreen(
                                              user: snapshot.data[index],
                                            ))));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 7,
                                      spreadRadius: 2,
                                      offset: const Offset(2, 4),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index].name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    snapshot.data[index].age,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  leading: ClipOval(
                                    child: Image.network(
                                      snapshot.data[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          var user = snapshot.data[index];

                                          if (favouriteStateList[index] ==
                                              false) {
                                            favouritedUserList.add(user);
                                            print("adedd!");
                                          } else {
                                            favouritedUserList.remove(user);
                                            print("removed!");
                                          }

                                          favouriteStateList[index] =
                                              !favouriteStateList[index];

                                          print(favouriteStateList);
                                        });
                                      },
                                      icon: _getFavouriteIcon(index)),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const SizedBox(
                        child: Center(
                          child: SpinKitPouringHourGlassRefined(
                              color: Colors.blueAccent),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
