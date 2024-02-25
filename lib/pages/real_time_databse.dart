import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../utils/create_bottom_sheet.dart';
import '../utils/update_bottom_sheet.dart';

class RealTimeCRUDEdatabase extends StatefulWidget {
  const RealTimeCRUDEdatabase({super.key});

  @override
  State<RealTimeCRUDEdatabase> createState() => _RealTimeCRUDEdatabaseState();
}

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.ref("Store Data");

class _RealTimeCRUDEdatabaseState extends State<RealTimeCRUDEdatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        title: const Text("Real Time database CRUD!"),
      ),
      // Read/Display
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
            query: databaseReference,
            itemBuilder: (context, snapshot, animation, index) {
              return ListTile(
                title: Text(snapshot.child("name").value.toString()),
                subtitle: Text(snapshot.child("address").value.toString()),
                leading: Text(snapshot.child("sn").value.toString()),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    // Update
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          updateBottomSheet(
                            context,
                            snapshot.child("name").value.toString(),
                            snapshot.child("id").value.toString(),
                            snapshot.child("sn").value.toString(),
                            snapshot.child("address").value.toString(),
                          );
                        },
                        leading: const Icon(Icons.edit),
                        title: const Text("Edit"),
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          databaseReference.child(snapshot.child("id").value.toString()).remove();
                        },
                        leading: const Icon(Icons.delete),
                        title: const Text("Delete"),
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              );
            },
          )),
        ],
      ),
      // Create
      floatingActionButton: FloatingActionButton(
        onPressed: () => createBottomSheet(context),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
