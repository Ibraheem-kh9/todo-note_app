import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../models/todo_model.dart';

class AddTodoWidget extends StatelessWidget {
  final TextEditingController titleCtrl = TextEditingController();
  final todoCtrl = Get.find<TodoController>();
  AddTodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        top: 10.0,
        bottom: 15.0,
      ),
      child: Card(
        child: TextFormField(
          controller: titleCtrl,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Add new Todo',
            border:
            const UnderlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: IconButton(
              onPressed: () {
                if(titleCtrl.text != ''){
                  TodoModel todo = TodoModel(title: titleCtrl.text);
                  todoCtrl.addTodo(todo);
                  titleCtrl.clear();
                }
                else{
                  return;
                }

              },
              icon: const Icon(
                Icons.done,
                color: Colors.indigo,
                size: 25.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
