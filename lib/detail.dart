import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> todo;
  final int index;

  DetailPage({required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(todo["name"]!),
            Text(todo["desc"]!),
            Text(todo["place"]!),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    var userAction = {
                      "action": 0, // Assuming 0 is edit completed and 1 is delete
                      "index": index
                    };
                    Navigator.pop(context, userAction);
                  },
                  icon: Icon(Icons.done),
                  label: Text("complete"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    var userAction = {
                      "action": 1, // Assuming 0 is edit completed and 1 is delete
                      "index": index
                    };
                    Navigator.pop(context, userAction);
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}