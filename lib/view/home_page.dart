import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../widget/addTodo.dart';
import '../widget/todoList_widget.dart';
import 'note_page.dart';


class TodoHomePage extends GetView<TodoController> {
  const TodoHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          ()=> Text(
            controller.tabIndex.value == 0 ? 'Todo' : 'Notes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: Column(
                children: [
                  AddTodoWidget(),
                  const Divider(
                    thickness: 3.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    color: Colors.indigo,
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                        left: 20.0,
                        top: 10.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'To Do : ${controller.todos != null ? controller.todos?.length : ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GetX(
                    init: Get.put<TodoController>(TodoController()),
                    builder: (TodoController todoCtrl) {
                      if (todoCtrl.todos != null) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: todoCtrl.todos!.length,
                              itemBuilder: (_, index) {
                                return TodoListWidget(
                                    todoModel: todoCtrl.todos![index]);
                              }),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ],
              ),
            ),
            NotePage(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (int index) {
            controller.changeTabIndex(index);
          },
          selectedItemColor: Colors.indigo,
          currentIndex: controller.tabIndex.value,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              label: 'Todo',
              icon: Icon(Icons.task),
            ),
            BottomNavigationBarItem(
              label: 'Notes',
              icon: Icon(Icons.notes),
            ),
          ],
        ),
      ),
    );
  }
}
