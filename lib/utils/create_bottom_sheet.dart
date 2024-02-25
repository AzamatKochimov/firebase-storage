import 'package:flutter/material.dart';

import '../pages/real_time_databse.dart';

void createBottomSheet(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController snController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isEmpty = false;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        color: Colors.blue[100],
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                "Create your items!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            isEmpty
                ? const Center(
                    child: Text(
                      "Fill in the blank spaces!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: "Name", hintText: "e.g.Azamat"),
            ),
            TextField(
              controller: snController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "S.N", hintText: "e.g.1"),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                  labelText: "Address", hintText: "e.g. A. Navoiy Street"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    snController.text.isNotEmpty &&
                    addressController.text.isNotEmpty) {
                  final id = DateTime.now().microsecond.toString();
                  databaseReference.child(id).set({
                    "name": nameController.text.toString(),
                    "sn": snController.text.toString(),
                    "address": addressController.text.toString(),
                    "id": id
                  });
                  Navigator.pop(context);
                } else {
                  isEmpty = true;
                }
              },
              child: const Text("Add"),
            )
          ],
        ),
      );
    },
  );
}
