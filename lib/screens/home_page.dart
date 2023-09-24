import "package:flutter/material.dart";
import "package:hive_flutter/adapters.dart";
import "package:hive_todo_app/data/database.dart";
import "package:hive_todo_app/util/dialog_box.dart";
import "package:hive_todo_app/util/todo_tile.dart";
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // Se for a primeira vez abrindo o app, vamos mostrar a lista default:
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // Já tem dados, então vamos:
      db.loadData();
    }

    super.initState();
  }

  // Abrindo a caixa:
  final _myBox = Hive.box("mybox");
  ToDoDatabase db = ToDoDatabase();

  // Text Controller:
  final _controller = TextEditingController();

  // Tapping the Checkbox:
  void checkBoxChange(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    // Update no db do hive:
    db.updateDatabase();
  }

  // Save New Task method:
  void saveNewTask() {
    if (_controller.text.isEmpty) {
      // Usando o pacote GetX -- https://pub.dev/packages/get
      // Lembre-se de declarálo no main.dart para englobar todo o app!
      Get.snackbar(
          "Warning!", "The task needs some description! Write something!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[200],
          duration: const Duration(seconds: 5));
    } else {
      setState(() {
        db.toDoList.add([
          _controller.text,
          false,
        ]);
        _controller.clear(); // Limpa o text do _controller.
      });
      Navigator.of(context).pop();
      // Update no db do hive:
      db.updateDatabase();
    }
  }

  // POP UP da TASK nova:
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            _controller,
            saveNewTask,
            () => Navigator.of(context).pop(),
          );
        });
  }

  // Deleting TASK:

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    // Update no db do hive:
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text(
          "TO DO HIVE",
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              db.toDoList[index][0],
              db.toDoList[index][1],
              (value) => checkBoxChange(value, index),
              (context) => deleteTask(index),
            );
          }),
    );
  }
}
