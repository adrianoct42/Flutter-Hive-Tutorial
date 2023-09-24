import 'package:hive_flutter/adapters.dart';

class ToDoDatabase {
  // Referenciando a box:
  final _myBox = Hive.box("mybox");

  List toDoList = [];

  // FIRST TIME EVER OPENING THE APP ONLY:
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false]
    ];
  }

  // Load the data from the database:
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // Update the database:
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
