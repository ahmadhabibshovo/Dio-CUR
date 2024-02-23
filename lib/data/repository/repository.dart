import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:scubetech/data/constant/constant.dart';
import 'package:scubetech/data/models/project_model.dart';

class Repository {
  Repository() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl, // Replace with your API base URL
        // Optional: Set timeout in milliseconds
      ),
    );
    dio.interceptors.add(PrettyDioLogger());
  }
  var dio;
  Future<List<Project>> getProjects() async {
    Response response =
        await dio.get('/all-project-elements/'); // Example GET request
    List<Project> projects =
        (response.data as List).map((json) => Project.fromJson(json)).toList();
    return projects;
  }

  Future<List> addProject(Project project) async {
    try {
      Response response =
          await dio.post('/add-project-elements/', data: project.toJson());

      return [response.data.toString(), true];
    } on DioException catch (error) {
      return [error.response!.data.toString(), false];
    }
  }

  Future<List> updateProject(Project project, int id) async {
    try {
      await dio.put('/update-project-elements/$id/', data: project.toJson());
      return ["Update Success", true];
    } on DioException catch (error) {
      return [error.response!.data.toString(), false];
    }
  }
}
