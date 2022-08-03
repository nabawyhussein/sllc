import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../global/errors/exeptions.dart';
import '../models/post_model_data_layer.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModelDataLayer>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModelDataLayer postModel);
  Future<Unit> addPost(PostModelDataLayer postModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModelDataLayer>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(BASE_URL + "/posts/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModelDataLayer> postModels = decodedJson
          .map<PostModelDataLayer>((jsonPostModelDataLayer) =>
              PostModelDataLayer.fromJson(jsonPostModelDataLayer))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModelDataLayer postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response =
        await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse(BASE_URL + "/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModelDataLayer postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response = await client.patch(
      Uri.parse(BASE_URL + "/posts/$postId"),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
