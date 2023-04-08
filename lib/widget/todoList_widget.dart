import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../models/todo_model.dart';

class TodoListWidget extends StatelessWidget {
  final todoCtrl = Get.find<TodoController>();
  final TodoModel todoModel;

  TodoListWidget({Key? key, required this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      child: Dismissible(
        key: ObjectKey(todoModel.todoId),
        onDismissed: (_) {
          todoCtrl.deleteTodo(todoModel.todoId);
        },
        direction: DismissDirection.endToStart,
        movementDuration: const Duration(milliseconds: 500),
        resizeDuration: const Duration(milliseconds: 600),
        background: Container(
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: Card(
          color: todoModel.done != false ? Colors.amber : Colors.white,
          child: Row(
            children: [
              Expanded(child: Text(todoModel.title ?? '',style: const TextStyle(fontSize: 20.0),)),
              Checkbox(
                checkColor: Colors.white,
                  activeColor: Colors.indigo,
                  value: todoModel.done,
                  onChanged: (newValue) {
                    todoCtrl.updateState(todoModel.todoId, newValue);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
