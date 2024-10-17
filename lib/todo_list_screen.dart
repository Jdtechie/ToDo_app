import 'package:flutter/material.dart';

class Todo {
  String title;
  String description;
  Todo({
    required this.title,
    required this.description,
  });
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreen();
}

class _TodoListScreen extends State<TodoListScreen> {
  final List<Todo> todoList = [];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void addTodo() {
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      setState(() {
        todoList.add(Todo(title: title, description: description));
      });
      titleController.clear();
      descriptionController.clear();
      Navigator.of(context).pop();
    }
  }

  void deleteTodo(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Task Here..'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('cancel'),
            ),
            ElevatedButton(
              onPressed: addTodo,
              child: Text('Add Task'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: todoList.isEmpty
          ? Center(
              child: Text(
                'No tasks added!',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(todoList[index].title),
                    subtitle: Text(todoList[index].description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteTodo(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTodoDialog,
        child: Icon(Icons.add),
        tooltip: 'Add New Task here',
      ),
    );
  }
}
