import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImageAndMoreState extends StatefulWidget {
  const UploadImageAndMoreState({super.key});

  @override
  State<UploadImageAndMoreState> createState() =>
      _UploadImageAndMoreStateState();
}

class _UploadImageAndMoreStateState extends State<UploadImageAndMoreState> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final CollectionReference _ref =
      FirebaseFirestore.instance.collection("User_Items");

      String imageUrl = "";

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 30,
              right: 30,
              left: 30,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text("Crate a new Item!"),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "e.g. Alex",
                  ),
                ),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: "Number",
                    hintText: "e.g. 1",
                  ),
                ),
                const SizedBox(height: 10),
                // ! ADD AN IMAGE
                // USED IMAGE PICKER HERE
                IconButton(
                  onPressed: () async {
                    final file = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (file == null) return;

                    String fileName =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    Reference refRoot = FirebaseStorage.instance.ref();
                    Reference refDirImage = refRoot.child("images");
                    Reference refImageToUpload = refDirImage.child(fileName);

                    try {
                      String fileExtension =
                          file.path.split('.').last.toLowerCase();

                      String contentType = 'image/jpeg';

                      if (fileExtension == 'png') {
                        contentType = 'image/png';
                      }

                      await refImageToUpload.putFile(
                        File(file.path),
                        SettableMetadata(contentType: contentType),
                      );

                      imageUrl = await refImageToUpload.getDownloadURL();
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  icon: const Icon(Icons.camera),
                ),

                //! ADD A NEW ITEM
                ElevatedButton(
                  onPressed: () async {
                    if(imageUrl.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please pick an image and upload!")));
                      return;
                    }
                    final String name = _nameController.text;
                    final int? number = int.tryParse(_numberController.text);
                    if (number != null) {
                      await _ref.add({
                        "name": name,
                        "number": number,
                        "image" : imageUrl,
                      });
                    }
                    _nameController.text = '';
                    _numberController.text = '';
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text("Create"),
                ),
              ],
            ),
          );
        });
  }

  late final Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    _stream = FirebaseFirestore.instance.collection("User_Items").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text("Upload and display items!"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error happened at ${snapshot.error}"),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> doc = querySnapshot.docs;
            List<Map> _items = doc.map((document) => document.data() as Map).toList();

            return ListView.builder(
                itemCount: _items.length,
                itemBuilder: (ctx, index) {
                  Map items = _items[index];
                  return ListTile(
                    title: Text("${items["name"]}"),
                    subtitle: Text("${items["number"]}"),
                    leading: Padding(
                      padding: const EdgeInsets.all(5),
                      child: CircleAvatar(
                        backgroundColor: Colors.purpleAccent,
                        radius: 27,
                        child: items.containsKey("image") ? ClipOval(
                          child: Image.network("${items["image"]}"),
                        ): CircleAvatar(),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _create();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
