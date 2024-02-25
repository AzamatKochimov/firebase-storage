import 'package:flutter/material.dart';

import '../pages/real_time_databse.dart';

void updateBottomSheet(BuildContext context, name, id, sn, address) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController snController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isEmpty = false;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      nameController.text = name;
      snController.text = sn;
      addressController.text = address;
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
              decoration:
                  const InputDecoration(labelText: "s.n", hintText: "e.g.S.N"),
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
                  databaseReference.child(id).update({
                    "name": nameController.text.toString(),
                    "sn": snController.text.toString(),
                    "address": addressController.text.toString(),
                  });
                  Navigator.pop(context);
                } else {
                  isEmpty = true;
                }
              },
              child: const Text("Update"),
            )
          ],
        ),
      );
    },
  );
}
