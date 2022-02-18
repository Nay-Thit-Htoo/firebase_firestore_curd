// ignore_for_file: avoid_print, argument_type_not_assignable_to_error_handler

import 'package:firebase_firestore_curd/SignIn.dart';
import 'package:firebase_firestore_curd/userlist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Firestore CURD',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).primaryTextTheme,
        ),
      ),

      // ignore: prefer_const_constructors
      home: HomePage(),
      color: Colors.black,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

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
          GestureDetector(
            onTap: () {
              _users
                  .where(
                    'name',
                    isEqualTo: _nameController.text,
                  )
                  .get()
                  .then((value) {
                if (value.size < 1) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Worng User Data"),
                  ));
                }
                for (var i = 0; i < value.size; i++) {
                  _users.doc(value.docs[i].id).get().then((v) {
                    Map<String, dynamic> data =
                        v.data() as Map<String, dynamic>;
                    if (data['password'] == _passwordController.text) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        // ignore: prefer_const_constructors
                        MaterialPageRoute(builder: (context) => UserList()),
                      );
                    } else if (i == value.size - 1) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Worng User Data"),
                      ));
                    }
                  });
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text("Sign Up",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                // ignore: prefer_const_constructors
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
            child: const Text("Sign In",
                style: TextStyle(fontSize: 18, color: Colors.white60)),
          )
        ],
      ),
    );
  }
}
