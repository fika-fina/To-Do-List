import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  var nameEditingController = TextEditingController();
  var descEditingController = TextEditingController();
  var placeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Name"),
              controller: nameEditingController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Description"),
              controller: descEditingController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Place"),
              controller: placeEditingController,
            ),
            ElevatedButton(
              onPressed: () {
                if (nameEditingController.text.isEmpty || descEditingController.text.isEmpty || placeEditingController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                } else {
                  var newItem = {
                    "name": nameEditingController.text,
                    "desc": descEditingController.text,
                    "place": placeEditingController.text,
                    "completed": false,
                  };
                  Navigator.pop(context, newItem);
                }
              },
              child: Text("Add data"),
            ),
          ],
        ),
      ),
    );
  }
}