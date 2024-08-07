import 'package:restapi/data/models/task_response_model.dart';
import 'package:restapi/data/models/add_task_request_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskRemoteDataSource {
  final String baseUrl = 'http://localhost:4000/api/tasks'; // Ganti dengan URL API Anda

  Future<List<TaskReponseModel>> getTasks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((task) => TaskReponseModel.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> addTask(AddTaskRequestModel task) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: task.toRawJson(),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(TaskReponseModel task) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: task.toRawJson(),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
