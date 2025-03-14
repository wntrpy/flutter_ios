import 'package:flutter/material.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final _controller = TextEditingController();

  //reference to hive box
  final _myBox = Hive.openBox('myBox');

  //list of todo
  List toDoList = [
    ["Unang task", false],
    ["Pangalawang task", false],
  ];

  void checkBoxChange(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    //add new task
    setState(() {
      toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop(); //close the dialog
    _controller.clear(); //clear the text field
  }

  void clearDialog(BuildContext context) {
    Navigator.of(context).pop();
    _controller.clear();
  }

  void createNewTask() {
    showDialog(
      // create new dialog widget, na ang content is yung irereturn na DialogBox
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => clearDialog(context),
          hintName: "", //yung default is add
          isEdit: false, //false para mapunta sa other option
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void modifyTask(int index) {
    setState(() {
      //showSnackBar(context, "TRUE");
      toDoList[index][0] = _controller.text;
      toDoList[index][1] = false;
    });
    Navigator.of(context).pop();
  }

  void editTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () => modifyTask(index),
          onCancel: () => clearDialog(context),
          hintName: toDoList[index][0].toString(), //set the todolist name
          isEdit: true, //true kasi naka edit mode
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("TO DO"),
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),

      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChange(value, index),
            deleteTask: (context) => deleteTask(index),
            editTask: (context) => editTask(index),
          );
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message), // The text you want to display
        duration: Duration(seconds: 2), // How long the SnackBar will be visible
      ),
    );
  }
}
