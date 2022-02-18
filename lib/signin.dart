// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_curd/main.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmpasswordController =
    TextEditingController();

final CollectionReference _users =
    FirebaseFirestore.instance.collection('users');

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('./assets/images/firebase-logo.png',
              width: 120, height: 120),
          const Text("Firestore CURD",
              style: TextStyle(fontSize: 26, color: Colors.white60)),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                // hintText: 'Enter your full name',
                labelText: 'User Name',
                labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: _confirmpasswordController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Re-Password',
                labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              if (_nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Enter user name"),
                ));
                return;
              }

              if (_passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Enter password"),
                ));
                return;
              }

              if (_confirmpasswordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Enter confirm password"),
                ));
                return;
              }

              if (_passwordController.text != _confirmpasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Enter same password for both"),
                ));
                return;
              }

              await _users.add({
                "name": _nameController.text,
                "password": _passwordController.text
              }).then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text("Sign In",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: const Text("Sign Up",
                style: TextStyle(fontSize: 18, color: Colors.white60)),
          )
        ],
      ),
    );
  }
}
