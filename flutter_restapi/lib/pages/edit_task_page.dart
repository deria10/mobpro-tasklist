import 'package:flutter/material.dart';
import 'package:restapi/data/datasource/task_remote_datasource.dart';
import 'package:restapi/data/models/task_response_model.dart';
import 'package:restapi/pages/home_page.dart'; // Pastikan ini sesuai dengan import halaman beranda Anda

class EditTaskPage extends StatefulWidget {
  final TaskReponseModel task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final updatedTask = TaskReponseModel(
                id: widget.task.id,
                title: _titleController.text,
                description: _descriptionController.text,
                createdAt: widget.task.createdAt,
                updatedAt: DateTime.now(),
                v: widget.task.v,
              );
              await TaskRemoteDataSource().updateTask(updatedTask);
              // Redirect to homepage
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>const HomePage(title: 'Task List',)), // Ganti HomePage() dengan widget halaman beranda Anda
                (route) => false,
              );
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}
