// ignore_for_file: file_names

import 'package:firebase_firestore_curd/editUser.dart';
import 'package:firebase_firestore_curd/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FileUploadList extends StatefulWidget {
  const FileUploadList({Key? key}) : super(key: key);

  @override
  _FileUploadListState createState() => _FileUploadListState();
}

class _FileUploadListState extends State<FileUploadList> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: const Text('User List'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Container(
                  padding: const EdgeInsets.all(3),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(
                      documentSnapshot['name'],
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      documentSnapshot['password'].toString() + " (password)",
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                // ignore: prefer_const_constructors
                                MaterialPageRoute(
                                    builder: (context) => EditUser(
                                        documentsnapshot: documentSnapshot)),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[800],
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _deleteUser(documentSnapshot.id);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[800],
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: const Icon(Icons.logout_rounded),
      ),
    );
  }

  // Deleteing a user by id
  Future<void> _deleteUser(String userId) async {
    await _users.doc(userId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a user')));
  }
}
