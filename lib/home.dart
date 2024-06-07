import 'dart:convert';
import 'package:flutter/material.dart';
import 'add.dart';
import 'detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  _loadTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todosString = prefs.getString("todos");
    if (todosString != null) {
      setState(() {
        _todos = List<Map<String, dynamic>>.from(jsonDecode(todosString));
      });
    }
  }

  _saveInStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("todos", jsonEncode(_todos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () async {
                var newItem = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPage()));
                if (newItem != null) {
                  setState(() {
                    _todos.add(newItem);
                  });
                  _saveInStorage();
                }
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: _todos[index]["completed"] ? Icon(Icons.check) : SizedBox(),
                  title: Text(_todos[index]["name"]!),
                  subtitle: Text(_todos[index]["desc"]!),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () async {
                    var action = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                              todo: _todos[index],
                              index: index,
                            )));
                    if (action != null) {
                      if (action["action"] == 0) {
                        setState(() {
                          _todos[index]["completed"] = !_todos[index]["completed"];
                        });
                        _saveInStorage();
                      } else if (action["action"] == 1) {
                        setState(() {
                          _todos.removeAt(action["index"]);
                        });
                        _saveInStorage();
                      }
                    }
                  },
                ),
              );
            }),
      ),
    );
  }
}