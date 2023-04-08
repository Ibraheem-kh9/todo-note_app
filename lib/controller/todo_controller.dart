import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo_model.dart';
import '../services/databaseConn.dart';


class TodoController extends GetxController {
  TodoModel todoModel = TodoModel();
  final Database _database = Database();
  final tabIndex = 0.obs;
  final isLightTheme = false.obs;

  Rxn<List<TodoModel>> todoList = Rxn<List<TodoModel>>();

  List<TodoModel>? get todos => todoList.value;

  @override
  void onInit() {
    super.onInit();
    todoList.bindStream(todoStream());
  }

  Future addTodo(TodoModel todoModel) async {
    await _database.firestore.collection('todo-fb').doc().set({
      'title': todoModel.title,
      'done': false,
      'dateCreated': Timestamp.now(),
    });
  }

  Stream<List<TodoModel>?> todoStream() {
    var result = _database.firestore
        .collection('todo-fb').orderBy('dateCreated',descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<TodoModel> list = [];
      snapshot.docs.forEach((element)
          {
        list.add(TodoModel.fromDocumentSnap(element));
      });
      return list;
    });
    return result;
  }

  Future<void> updateState(String? todoId, bool? done) async {
    var res = await _database.firestore
        .collection('todo-fb')
        .doc(todoId)
        .update({'done': done});
    return res;
  }

  Future deleteTodo(String? todoId) async {
    await _database.firestore.collection('todo-fb').doc(todoId).delete();
  }

  void changeTabIndex(int index){
    tabIndex.value = index;
  }
}
