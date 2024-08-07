import 'package:flutter/material.dart';
import 'package:restapi/data/datasource/task_remote_datasource.dart';
import 'package:restapi/data/models/task_response_model.dart';
import 'package:restapi/pages/add_task_page.dart';
import 'package:restapi/pages/detail_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;
  List<TaskReponseModel> tasks = [];

  Future<void> getTasks() async {
    setState(() {
      isLoaded = true;
    });
    try {
      final model = await TaskRemoteDataSource().getTasks();
      setState(() {
        tasks = model;
        isLoaded = false;
      });
    } catch (e) {
      setState(() {
        isLoaded = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load tasks: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 2,
        backgroundColor: Colors.yellow,
      ),
      body: isLoaded
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailTaskPage(task: tasks[index]),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(tasks[index].title),
                      subtitle: Text(tasks[index].description),
                      trailing: const Icon(Icons.check_circle),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddTaskPage();
          }));
          getTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
