import 'package:flutter/material.dart';

import 'ListPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validation() {
    if (_userNameController.text == "User" &&
        _passwordController.text == "1234") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ListPage()));
    } else {
      AlertDialog alertDialog = AlertDialog(
        title: const Text("Invalid Input!"),
        content:
            const Text("you have to try your username and password again!"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"))
        ],
      );

      showDialog(
        context: context,
        builder: (context) => alertDialog,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset("assets/logoforquiz.png"),
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: "What do people call you?",
                  labelText: "Name *",
                ),
                validator: (String? value) {
                  if (value != null && value.contains('@')) {
                    return "Do not use @ sign.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: "Enter your password",
                  labelText: "Password *",
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: _validation,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                ),
                child: const Text(
                  "Log in",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
